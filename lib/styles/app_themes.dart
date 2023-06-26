import 'package:flutter/material.dart';
import 'package:provider_sample/styles/app_colors.dart';

class AppThemes {
  static light() => ThemeData(
      primaryColor: AppColors.blue,
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.blue),
      scaffoldBackgroundColor: AppColors.neutral[0],
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(AppColors.black[0]),
        fillColor: MaterialStateProperty.all(AppColors.blue[80]),
      ),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: AppColors.blue));

  static dark() => ThemeData(
      primaryColor: AppColors.blue,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.blue[100]),
      scaffoldBackgroundColor: AppColors.black[90],
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(AppColors.black[0]),
        fillColor: MaterialStateProperty.all(AppColors.blue[90]),
      ),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: AppColors.blue[100]));
}
