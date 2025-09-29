import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/model/Failure.dart';
import 'package:e_commerce/data/model/category_dm.dart';
import 'package:e_commerce/domain/main_repo/main_repo.dart';
import 'package:e_commerce/ui/screens/utils/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllCategoriesUseCase extends Cubit<BaseState>  {
  MainRepo repo;

  GetAllCategoriesUseCase(this.repo) : super(BaseInitialState());

  void execute() async {
    Either<Failure, List<CategoryDM>> either =await repo.getCategories();
    either.fold(
          (error) => emit(BaseErrorState(error.errorMessage)),
          (success) => emit(BaseSuccessState<List<CategoryDM>>(data: success)),
    );


  }
}
