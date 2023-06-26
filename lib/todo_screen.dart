import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(title: const Text('TODO List')),
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
