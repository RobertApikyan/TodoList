import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_sample/styles/app_colors.dart';
import 'package:provider_sample/styles/app_themes.dart';
import 'package:provider_sample/todo_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

final themeProvider = StateProvider((ref) => ThemeMode.light);

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      themeMode: themeMode,
      theme: AppThemes.light(),
      darkTheme: AppThemes.dark(),
      home: const TodoScreen(),
    );
  }
}
