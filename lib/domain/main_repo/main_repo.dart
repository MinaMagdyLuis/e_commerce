import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/model/Failure.dart';
import 'package:e_commerce/data/model/cart_dm.dart';
import 'package:e_commerce/data/model/category_dm.dart';
import 'package:e_commerce/data/model/product_dm.dart';


abstract class MainRepo {
  Future<Either<Failure, List<CategoryDM>>> getCategories();

  Future<Either<Failure, List<ProductDM>>> getProducts();
  Future<Either<Failure,CartDM>> getLoggedUserCart();
  Future<Either<Failure,CartDM>> addProductToCart(String id);
  Future<Either<Failure,CartDM>> removeProductFromCart(String id);
}
