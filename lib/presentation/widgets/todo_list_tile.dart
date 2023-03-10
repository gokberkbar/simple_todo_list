import 'package:flutter/material.dart';

import '../../models/todo.dart';

class TodoListTile extends StatelessWidget {
  final Todo todo;
  final Function(bool updatedStatus, Todo todo) onChanged;
  final Function(Todo todo) onDeletePressed;

  const TodoListTile({
    required this.todo,
    required this.onChanged,
    required this.onDeletePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: todo.completed,
          onChanged: (_) {
            onChanged(!todo.completed, todo);
          },
        ),
        Expanded(
          child: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.completed ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
        IconButton(
          splashRadius: 23,
          icon: const Icon(
            Icons.delete,
            color: Colors.redAccent,
          ),
          onPressed: () {
            onDeletePressed(todo);
          },
        ),
      ],
    );
  }
}
