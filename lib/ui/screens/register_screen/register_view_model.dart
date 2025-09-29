import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/model/Failure.dart';
import 'package:e_commerce/data/model/request/register_auth_body.dart';
import 'package:e_commerce/domain/use_cases/register_use_case.dart';
import 'package:e_commerce/ui/screens/utils/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class RegisterViewModel extends Cubit<BaseState> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RegisterViewModel(this.registerUseCase) : super(BaseInitialState());
  RegisterUseCase registerUseCase;

  void register() async {
    if (!formKey.currentState!.validate()) return;

    emit(BaseLoadingState());

    Either<Failure, bool> response = await registerUseCase.register(
      RegisterAuthBody(
        name: fullNameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: mobileController.text,
        rePassword: rePasswordController.text,
      ),
    );

    response.fold(
      (error) {
        emit(BaseErrorState(error.errorMessage));
        print('+++++++++++++++++++++++++++++++++++++++');
        print(error.errorMessage);
        print('+++++++++++++++++++++++++++++++++++++++');
      },
      (success) {
        emit(BaseSuccessState());
      },
    );
  }
}
