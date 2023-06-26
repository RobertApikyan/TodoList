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
          primaryColor: AppColors.blue,
          appBarTheme: const AppBarTheme(backgroundColor: AppColors.blue),
          scaffoldBackgroundColor: AppColors.neutral[0],
          checkboxTheme: CheckboxThemeData(
              checkColor: MaterialStateProperty.all(AppColors.black[0]),
              fillColor: MaterialStateProperty.all(AppColors.blue[80])),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: AppColors.blue)),
      home: const TodoScreen(),
    );
  }
}
