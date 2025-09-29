import 'dart:async';

import 'package:e_commerce/data/utils/shared_preference_utils.dart';
import 'package:e_commerce/domain/di/di.dart';
import 'package:e_commerce/ui/screens/login_screen/login_screen.dart';
import 'package:e_commerce/ui/screens/main_screen/main_screen.dart';
import 'package:e_commerce/ui/screens/utils/app_assets.dart';
import 'package:flutter/material.dart';

import '../../../data/model/auth_response.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () async {
      var prefs = getIt<SharedPreferenceUtils>();
      User? user = await prefs.getUser;
      if (user == null) {
        Navigator.pushNamed(context, LoginScreen.routeName);
      } else {
        Navigator.pushNamed(context, MainScreen.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        AppAssets.splashBackground,
        fit: BoxFit.fill,
        width: double.infinity,
      ),
    );
  }
}
