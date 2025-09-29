import 'package:e_commerce/ui/screens/utils/app_colors.dart';
import 'package:flutter/material.dart';

class RegistrationBtn extends StatelessWidget {
  void Function() onPress;
  String text;

  RegistrationBtn({super.key, required this.onPress, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(vertical: 22),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: onPress,
      child: Text(text, style: Theme.of(context).textTheme.titleSmall),
    );
  }
}
