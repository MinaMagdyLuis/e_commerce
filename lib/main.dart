import 'package:e_commerce/domain/di/di.dart';
import 'package:e_commerce/ui/screens/cart_screen/cart_screen.dart';
import 'package:e_commerce/ui/screens/login_screen/login_screen.dart';
import 'package:e_commerce/ui/screens/main_screen/main_screen.dart';
import 'package:e_commerce/ui/screens/main_screen/tabs/home_tab/home_view_model_cubit.dart';
import 'package:e_commerce/ui/screens/product_details_screen/product_details_screen.dart';
import 'package:e_commerce/ui/screens/register_screen/register_screen.dart';
import 'package:e_commerce/ui/screens/splash_screen/splash_screen.dart';
import 'package:e_commerce/ui/screens/utils/app_theme.dart';
import 'package:e_commerce/ui/shared_view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  configureDependencies();

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(create: (_) => getIt<CartViewModel>()),
      BlocProvider(create: (_) => getIt<HomeViewModelCubit>()),

    ] , child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        MainScreen.routeName: (_) => MainScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        ProductDetailsScreen.routeName:(_)=>ProductDetailsScreen(),
        CartScreen.routeName:(_)=>CartScreen(),
      },
      initialRoute: SplashScreen.routeName,
      themeMode: ThemeMode.light,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
    );
  }
}
