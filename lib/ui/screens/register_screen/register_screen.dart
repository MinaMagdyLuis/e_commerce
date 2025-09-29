import 'package:e_commerce/domain/di/di.dart';
import 'package:e_commerce/ui/screens/register_screen/register_view_model.dart';
import 'package:e_commerce/ui/screens/utils/app_assets.dart';
import 'package:e_commerce/ui/screens/utils/base_state.dart';
import 'package:e_commerce/ui/screens/utils/dialogs_utils.dart';
import 'package:e_commerce/ui/screens/widgets/custom_text_field.dart';
import 'package:e_commerce/ui/screens/widgets/form_lable_widget.dart';
import 'package:e_commerce/ui/screens/widgets/registration_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'RegisterScreen';

  RegisterScreen({super.key});

  RegisterViewModel viewModel = getIt();
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterViewModel, BaseState>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is BaseLoadingState) {
          showLoading(context);
        } else if (state is BaseSuccessState) {
          Navigator.pop(context);
        } else if (state is BaseErrorState) {
          Navigator.pop(context);

          showError(context, state.errorMessage);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 60),
                    Image.asset(AppAssets.routeLogo),
                    const SizedBox(height: 40),
                    FormLabelWidget(label: 'Full Name'),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: viewModel.fullNameController,
                      hintText: 'enter your full name',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Full name is required';
                        }
                        final regex = RegExp(r'^[a-zA-Z ]{3,}$');
                        if (!regex.hasMatch(value.trim())) {
                          return 'Enter a valid full name';
                        }
                        return null;
                      },
                      type: TextInputType.name,
                    ),

                    const SizedBox(height: 20),
                    FormLabelWidget(label: 'Mobile Number'),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: viewModel.mobileController,
                      hintText: 'enter your mobile no',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mobile number is required';
                        }
                        final regex = RegExp(r'^\+?\d{10,15}$');
                        if (!regex.hasMatch(value.trim())) {
                          return 'Enter a valid mobile number';
                        }
                        return null;
                      },
                      type: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),

                    FormLabelWidget(label: "E-mail address"),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: viewModel.emailController,
                      hintText: 'enter your email address',
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
                      type: TextInputType.emailAddress,
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

                    const SizedBox(height: 20),
                    FormLabelWidget(label: 'rePassword'),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: viewModel.rePasswordController,
                      hintText: 'reenter your password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }

                        if (value.length < 8) {
                          return 'Password must be at least 8 chars, include letters & numbers';
                        }
                        if (viewModel.passwordController.text != value) {
                          return 'Password does not match';
                        }
                        return null;
                      },
                      type: TextInputType.text,
                      isPassword: true,
                    ),

                    const SizedBox(height: 50),
                    RegistrationBtn(
                      onPress: () {
                        viewModel.register();
                      },
                      text: "Sign up",
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
