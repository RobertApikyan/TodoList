import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider_sample/state_lifecycle_observer.dart';
import 'package:provider_sample/todo_repo.dart';
import 'package:provider_sample/todo_screen.dart';

class CreateTodoViewModel {
  CreateTodoViewModel();

  String name = '';
  String? nameErrorText;
}

class CreateTodoController extends ChangeNotifier
    implements StateLifecycleObserver {
  CreateTodoController(
    this.ref,
  ) : super();

  static AutoDisposeChangeNotifierProvider<CreateTodoController> provider =
      ChangeNotifierProvider.autoDispose(
    CreateTodoController.new,
  );

  ChangeNotifierProviderRef<CreateTodoController> ref;
  final createVm = CreateTodoViewModel();

  void onNameChanged(String name) {
    createVm.name = name;
    validate();
  }

  void onCreateTodoPressed(BuildContext context) {
    if (validate()) {
      ref.read(TodoRepository.provider).addTodo(createVm.name);
      ref.invalidate(todoVmsProvider);
      Navigator.of(context).pop();
    }
  }

  bool validate() {
    final isValid = createVm.name.isNotEmpty;
    createVm.nameErrorText = !isValid ? 'Required Field' : null;
    notifyListeners();
    if (isValid) {
      return true;
    }
    return false;
  }

  @override
  void onClose() {
    debugPrint('TODO ON_CLOSE');
  }

  @override
  void onInit() {
    debugPrint('TODO ON_INIT');
  }
}

class CreateTodo extends HookConsumerWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = StateLifecycleObserver.useStateLifecycleObserver(
        ref.watch(CreateTodoController.provider));
    return Scaffold(
      appBar: AppBar(title: const Text('TODO Create')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              maxLines: 1,
              onChanged: controller.onNameChanged,
              textAlign: TextAlign.start,
              scrollPadding: EdgeInsets.zero,
              onSubmitted: (value) => controller.onCreateTodoPressed(context),
            ),
            const SizedBox(
              height: 8,
            ),
            if (controller.createVm.nameErrorText != null)
              Text(
                controller.createVm.nameErrorText!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.done_rounded, color: Colors.white),
        onPressed: () => controller.onCreateTodoPressed(context),
      ),
    );
  }
}
