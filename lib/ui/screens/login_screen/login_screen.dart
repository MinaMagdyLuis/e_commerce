import 'package:e_commerce/domain/di/di.dart';
import 'package:e_commerce/ui/screens/login_screen/login_view_model.dart';
import 'package:e_commerce/ui/screens/main_screen/main_screen.dart';
import 'package:e_commerce/ui/screens/register_screen/register_screen.dart';
import 'package:e_commerce/ui/screens/utils/app_assets.dart';
import 'package:e_commerce/ui/screens/utils/base_state.dart';
import 'package:e_commerce/ui/screens/utils/dialogs_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/form_lable_widget.dart';
import '../widgets/registration_btn.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'LoginScreen';

  LoginViewModel viewModel = getIt();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: BlocListener<LoginViewModel, BaseState>(
            bloc: viewModel,
            listener: (context, state) {
              if (state is BaseLoadingState) {
                showLoading(context);
                print(state);
              } else if (state is BaseSuccessState) {

                Navigator.pop(context);
                Navigator.pushNamed(context, MainScreen.routeName);
              } else if (state is BaseErrorState) {
                print(state);
                Navigator.pop(context);
                showError(context, state.errorMessage);
              }
            },
            child: SingleChildScrollView(
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 60),
                    Image.asset(AppAssets.routeLogo),
                    const SizedBox(height: 40),

                    Text(
                      'Welcome back to route',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),

                    Text(
                      'Please sign in with your mail',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 30),

                    FormLabelWidget(label: 'User Name'),

                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: viewModel.emailController,
                      hintText: 'enter your user name',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email is required';
                        }
                        final regex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (!regex.hasMatch(value.trim())) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      type: TextInputType.text,
                    ),

                    const SizedBox(height: 20),

                    FormLabelWidget(label: 'Password'),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: viewModel.passwordController,
                      hintText: 'enter your password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }

                        if (value.length < 8) {
                          return 'Password must be at least 8 chars, include letters & numbers';
                        }
                        return null;
                      },
                      type: TextInputType.text,
                      isPassword: true,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: FormLabelWidget(label: 'Forgot password'),
                    ),
                    const SizedBox(height: 20),

                    RegistrationBtn(
                      onPress: () {
                        viewModel.login();
                      },
                      text: "Log in",
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            RegisterScreen.routeName,
                          );
                        },
                        child: Text(
                          "Don’t have an account? Create Account",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
