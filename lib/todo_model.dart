import 'package:flutter/material.dart';

class Todo {
  const Todo({
    required this.id,
    required this.name,
    required this.isDone,
  });

  final String id;
  final String name;
  final bool isDone;

  Todo copyWith({
    String? name,
    bool? isDone,
  }) {
    return Todo(
      id: id,
      name: name ?? this.name,
      isDone: isDone ?? this.isDone,
    );
  }
}

class TodoViewModel {
  TodoViewModel(this.model)
      : name = model.name,
        backgroundColor =
            model.isDone ? Colors.lightGreen[100]! : Colors.blue[100]!;

  final Todo model;
  final String name;
  final Color backgroundColor;
}
