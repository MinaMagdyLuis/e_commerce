import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/model/Failure.dart';
import 'package:e_commerce/domain/use_cases/login_use_case.dart';
import 'package:e_commerce/ui/screens/utils/base_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
@injectable
class LoginViewModel extends Cubit<BaseState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginUseCase loginUseCase;

  LoginViewModel(this.loginUseCase) : super(BaseInitialState());

  login() async {
    if (!formKey.currentState!.validate()) return;
    emit(BaseLoadingState());
    Either<Failure, bool> response = await loginUseCase.execute(
      emailController.text,
      passwordController.text,
    );
    response.fold(
      (error) {
        emit(BaseErrorState(error.errorMessage));
      },
      (success) {
        emit(BaseSuccessState());
      },
    );
  }
}
