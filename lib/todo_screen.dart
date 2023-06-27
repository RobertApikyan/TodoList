import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_sample/main.dart';
import 'package:provider_sample/styles/app_colors.dart';
import 'package:provider_sample/styles/app_theme_extensions.dart';
import 'package:provider_sample/todo_create.dart';
import 'package:provider_sample/todo_item.dart';
import 'package:provider_sample/todo_model.dart';
import 'package:provider_sample/todo_repo.dart';

import 'defaults.dart';
import 'state_lifecycle_observer.dart';

FutureProvider<List<TodoViewModel>> todoVmsProvider =
    FutureProvider((ref) async {
  final todos = await ref.watch(TodoRepository.provider).fetchTodoList();
  return todos.reversed
      .map(
        TodoViewModel.new,
      )
      .toList();
});

class TodoScreenController extends ChangeNotifier
    implements StateLifecycleObserver {
  TodoScreenController(this.ref);

  static ChangeNotifierProvider<TodoScreenController> provider =
      ChangeNotifierProvider((ref) => TodoScreenController(ref));

  ChangeNotifierProviderRef ref;

  void onCheckChanged(bool isChecked, TodoViewModel vm) {
    final repo = ref.read(TodoRepository.provider);
    final todo = vm.model.copyWith(isDone: isChecked);
    repo.updateTodo(todo);
    ref.invalidate(todoVmsProvider);
  }

  void onCreateTodoPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const CreateTodo(),
    ));
  }

  @override
  void onClose() {}

  @override
  void onInit() {}
}

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Text('TODO List'), actions: [
          CupertinoSwitch(
            activeColor: AppColors.blue[40],
            trackColor: AppColors.black,
            value: ref.watch(themeProvider) == ThemeMode.light,
            onChanged: (value) => ref.read(themeProvider.notifier).state =
                value ? ThemeMode.light : ThemeMode.dark,
          )
        ]),
        body: ref.watch(todoVmsProvider).when(
              data: (data) => _dataContent(context, ref, data),
              error: (error, stackTrace) => errorBuilder(context),
              loading: () => loadingBuilder(context),
            ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () => ref
              .read(TodoScreenController.provider)
              .onCreateTodoPressed(context),
        ),
      );
  }

  Widget _dataContent(
      BuildContext context, WidgetRef ref, List<TodoViewModel> vms) {
    final controller = ref.watch(TodoScreenController.provider);
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16),
      itemCount: vms.length,
      itemBuilder: (context, index) => TodoItem(
        viewModel: vms[index],
        onChanged: (isChecked) =>
            controller.onCheckChanged(isChecked ?? false, vms[index]),
      ),
    );
  }
}
