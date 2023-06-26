import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_sample/styles/app_color.dart';
import 'package:provider_sample/todo_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          appBarTheme:
              const AppBarTheme(backgroundColor: AppColors.primaryColor),
          scaffoldBackgroundColor: AppColors.backgroundColor,
          checkboxTheme: CheckboxThemeData(
              checkColor: MaterialStateProperty.all(AppColors.white),
              fillColor: MaterialStateProperty.all(AppColors.selectedCheckboxColor)),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: AppColors.primaryColor)),
      home: const TodoScreen(),
    );
  }
}
