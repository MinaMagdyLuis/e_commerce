import 'package:e_commerce/ui/screens/utils/app_colors.dart';
import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;

  final String? Function(String?)? validator;
  final TextInputType type;

   const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    required this.validator,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        hintStyle: Theme.of(context).textTheme.titleSmall,
        fillColor: AppColors.white,
        filled: true,
      ),
      validator: validator,
      controller: controller,
      style: Theme.of(
        context,
      ).textTheme.titleSmall?.copyWith(color: AppColors.black),
      keyboardType: type,
      obscureText: isPassword,
    );
  }
}
