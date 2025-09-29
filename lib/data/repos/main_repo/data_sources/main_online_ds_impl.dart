import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/model/cart_dm.dart';
import 'package:e_commerce/data/model/cart_response.dart';
import 'package:e_commerce/data/model/categories_response.dart';
import 'package:e_commerce/data/model/Failure.dart';
import 'package:e_commerce/data/model/Products_response.dart';
import 'package:e_commerce/data/model/category_dm.dart';
import 'package:e_commerce/data/model/product_dm.dart';
import 'package:e_commerce/data/utils/shared_preference_utils.dart';
import 'package:e_commerce/domain/main_repo/data_sources/main_online_ds.dart';
import 'package:e_commerce/ui/screens/utils/constants.dart';
import 'package:e_commerce/ui/screens/utils/end_points.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MainOnlineDS)
class MainOnlineDSImpl extends MainOnlineDS {
  final SharedPreferenceUtils sharedPreferenceUtils;

  MainOnlineDSImpl(this.sharedPreferenceUtils);

  @override
  Future<Either<Failure, List<CategoryDM>>> getCategories() async {
    try {
      Uri url = Uri.https(EndPoints.baseUrl, EndPoints.categories);
      Response response = await get(url);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          CategoriesResponse myResponse = categoriesResponseFromJson(response.body);
          if (myResponse.data?.isNotEmpty == true) {
            return Right(myResponse.data!);
          }
        } catch (_) {
          return Left(Failure("Invalid categories response format"));
        }
      }
      return Left(Failure(Constants.defaultErrorMessage));
    } catch (error, stack) {
      print("getCategories error: $error\n$stack");
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductDM>>> getProducts() async {
    try {
      Uri url = Uri.https(EndPoints.baseUrl, EndPoints.products);
      Response response = await get(url);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          ProductsResponse myResponse = productsResponseFromJson(response.body);
          if (myResponse.data?.isNotEmpty == true) {
            return Right(myResponse.data!);
          }
        } catch (_) {
          return Left(Failure("Invalid products response format"));
        }
      }
      return Left(Failure(Constants.defaultErrorMessage));
    } catch (error, stack) {
      print("getProducts error: $error\n$stack");
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, CartDM>> getLoggedUserCart() async {
    try {
      Uri url = Uri.https(EndPoints.baseUrl, EndPoints.cart);
      String? token = await sharedPreferenceUtils.getToken;
      if (token == null) return Left(Failure("User not logged in"));

      Response response = await get(url, headers: {"token": token});

      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          CartResponse cartResponse = cartResponseFromJson(response.body);
          if (cartResponse.cartDM != null) {
            return Right(cartResponse.cartDM!);
          }
        } catch (_) {
          return Left(Failure("Invalid cart response format"));
        }
      }
      return Left(Failure(Constants.defaultErrorMessage));
    } catch (error, stack) {
      print("getLoggedUserCart error: $error\n$stack");
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, CartDM>> addProductToCart(String id) async {
    try {
      Uri url = Uri.https(EndPoints.baseUrl, EndPoints.cart);
      String? token = await sharedPreferenceUtils.getToken;
      if (token == null) return Left(Failure("User not logged in"));

      Response response = await post(
        url,
        headers: {
          "token": token,
          "Content-Type": "application/json",
        },
        body: jsonEncode({"productId": id}),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return getLoggedUserCart();
      } else {
        try {
          Map<String, dynamic> json = jsonDecode(response.body);
          return Left(Failure(json['message'] ?? Constants.defaultErrorMessage));
        } catch (_) {
          return Left(Failure("Unexpected response: ${response.body}"));
        }
      }
    } catch (error, stack) {
      print("addProductToCart error: $error\n$stack");
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, CartDM>> removeProductFromCart(String id) async {
    try {
      Uri url = Uri.https(EndPoints.baseUrl, "${EndPoints.cart}/$id");
      String? token = await sharedPreferenceUtils.getToken;
      if (token == null) return Left(Failure("User not logged in"));

      Response response = await delete(url, headers: {"token": token});

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return getLoggedUserCart();
      } else {
        try {
          Map<String, dynamic> json = jsonDecode(response.body);
          return Left(Failure(json['message'] ?? Constants.defaultErrorMessage));
        } catch (_) {

          return Left(Failure("Unexpected response: ${response.body}"));
        }
      }
    } catch (error, stack) {

      print("removeProductFromCart error: $error\n$stack");
      return Left(Failure(error.toString()));
    }
  }
}
