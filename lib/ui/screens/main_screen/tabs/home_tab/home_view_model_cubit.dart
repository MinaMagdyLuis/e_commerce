import 'package:bloc/bloc.dart';
import 'package:e_commerce/domain/use_cases/get_all_categories_usecase.dart';
import 'package:e_commerce/domain/use_cases/get_all_products_usecase.dart';
import 'package:e_commerce/ui/screens/utils/base_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModelCubit extends Cubit<BaseState> {
  HomeViewModelCubit(this.getAllProductsUseCase, this.getAllCategoriesUseCase)
    : super(BaseInitialState());
  GetAllCategoriesUseCase getAllCategoriesUseCase;
  GetAllProductsUseCase getAllProductsUseCase;

  loadCategories() async {

       getAllCategoriesUseCase.execute();

  }

  loadProducts()async {
    emit(BaseLoadingState());
    getAllProductsUseCase.execute();

  }
}
