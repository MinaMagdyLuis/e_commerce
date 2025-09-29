



import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/model/Failure.dart';
import 'package:e_commerce/data/model/cart_dm.dart';
import 'package:e_commerce/domain/main_repo/main_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class RemoveProductToCartUseCase{
  MainRepo repo;
  RemoveProductToCartUseCase(this.repo);


  Future<Either<Failure,CartDM>> execute(String id){
    return repo.removeProductFromCart(id);
  }



}