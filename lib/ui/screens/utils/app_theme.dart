import 'package:e_commerce/ui/screens/utils/app_colors.dart';
import 'package:flutter/material.dart';


abstract class AppTheme {
  static const TextStyle appBarTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
    color: AppColors.white,
    );
  static const TextStyle taskTitleTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
    color: AppColors.primary,
  );

  static const TextStyle taskDescriptionTextStyle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14,
    color: AppColors.lightBlue,
  );
  static const TextStyle bottomSheetTitleTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: AppColors.black,
  );

  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    textTheme: TextTheme(
      titleSmall: TextStyle(
        fontSize: 18,
        color: AppColors.black.withValues(alpha: 0.7),
        fontWeight: FontWeight.w300

      ),
      titleMedium: TextStyle(
        fontSize: 24,
          color: AppColors.white,
          fontWeight: FontWeight.w600

      ),
      titleLarge:TextStyle(
          fontSize: 16,
          color: AppColors.white,
          fontWeight: FontWeight.w300

      ),
      bodySmall: TextStyle(
          fontSize: 18,
          color: AppColors.white,
          fontWeight: FontWeight.w500

      ),
   ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      titleTextStyle: appBarTextStyle,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(size: 32),
      unselectedIconTheme: IconThemeData(size: 32),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
    ),
    scaffoldBackgroundColor: AppColors.white,
    dividerTheme: DividerThemeData(thickness: 3,color: AppColors.primary)

  );
  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      titleTextStyle: appBarTextStyle,
      centerTitle: true,
    ),
  );
}
