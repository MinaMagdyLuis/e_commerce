import 'package:e_commerce/ui/screens/utils/constants.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(Constants.defaultErrorMessage),);
  }
}
