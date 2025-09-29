import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/model/Failure.dart';
import 'package:e_commerce/data/model/cart_dm.dart';
import 'package:e_commerce/data/model/category_dm.dart';
import 'package:e_commerce/data/model/product_dm.dart';
import 'package:e_commerce/domain/main_repo/data_sources/main_online_ds.dart';
import 'package:e_commerce/domain/main_repo/main_repo.dart';
import 'package:e_commerce/ui/screens/utils/constants.dart';
import 'package:e_commerce/ui/screens/utils/extensions.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MainRepo)
class MainRepoImpl extends MainRepo {
  Connectivity connectivity;
  MainOnlineDS ds;

  MainRepoImpl(this.connectivity, this.ds);

  @override
  Future<Either<Failure, List<CategoryDM>>> getCategories() async {
    if (await connectivity.isInternetConnected) {
      return await ds.getCategories();
    } else {
      return Left(Failure(Constants.networkErrorMessage));
    }
  }

  @override
  Future<Either<Failure, List<ProductDM>>> getProducts() async{
    if (await connectivity.isInternetConnected) {
      return await ds.getProducts();
    } else {
      return Left(Failure(Constants.networkErrorMessage));
    }  }

  @override
  Future<Either<Failure, CartDM>> addProductToCart(String id)async {
    if (await connectivity.isInternetConnected) {
      return  ds.addProductToCart(id);
    } else {
      return Left(Failure(Constants.networkErrorMessage));
    }
  }

  @override
  Future<Either<Failure, CartDM>> getLoggedUserCart() async{
    if (await connectivity.isInternetConnected) {
      return  ds.getLoggedUserCart();
    } else {
      return Left(Failure(Constants.networkErrorMessage));
    }
  }

  @override
  Future<Either<Failure, CartDM>> removeProductFromCart(String id) async{
    if (await connectivity.isInternetConnected) {
      return  ds.removeProductFromCart(id);
    } else {
      return Left(Failure(Constants.networkErrorMessage));
    }
}}
