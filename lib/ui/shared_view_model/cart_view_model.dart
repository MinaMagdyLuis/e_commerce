import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/model/Failure.dart';
import 'package:e_commerce/data/model/cart_dm.dart';
import 'package:e_commerce/data/model/cart_product.dart';
import 'package:e_commerce/data/model/product_dm.dart';
import 'package:e_commerce/domain/use_cases/add_product_to_cart_usecase.dart';
import 'package:e_commerce/domain/use_cases/get_logged_user_cart_usecase.dart';
import 'package:e_commerce/domain/use_cases/remove_product_from_cart_usecase.dart';
import 'package:e_commerce/ui/screens/utils/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartViewModel extends Cubit<BaseState> {
  CartViewModel(
    this.addProductToCartUseCase,
    this.removeProductToCartUseCase,
    this.getLoggedUserCartUseCase,
  ) : super(BaseInitialState());
  GetLoggedUserCartUseCase getLoggedUserCartUseCase;
  AddProductToCartUseCase addProductToCartUseCase;
  RemoveProductToCartUseCase removeProductToCartUseCase;
  CartDM? cartDM;

  void removeProductFromCart(String id) async {
    Either<Failure, CartDM> either = await removeProductToCartUseCase.execute(
      id,
    );
    either.fold(
      (error) => emit(BaseErrorState(error.errorMessage)),
      (cart) {
        cartDM=cart;
        emit(BaseSuccessState());
      }
      );

  }

  void addProductToCart(String id) async {
    Either<Failure, CartDM> either = await addProductToCartUseCase.execute(id);
    either.fold((error) => emit(BaseErrorState(error.errorMessage)), (cart) {
      cartDM = cart;
      emit(BaseSuccessState());
    });
  }

  void loadCart() async {
    Either<Failure, CartDM> either = await getLoggedUserCartUseCase.execute();
    either.fold((error) => emit(BaseErrorState(error.errorMessage)), (cart) {
      cartDM = cart;
      emit(BaseSuccessState());
    });
  }
  CartProduct? isCartProduct(ProductDM product){

    if (cartDM != null && cartDM!.cartProducts != null) {
      var cartProducts = cartDM!.cartProducts;

      for (int i = 0; i < cartProducts!.length; i++) {
        if (cartProducts[i].product?.id == product.id) {
          return cartProducts[i];

        }
      }
    }
return null;
  }
}
