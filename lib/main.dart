import 'package:flutter/material.dart';

import 'presentation/screens/todos/todos_view.dart';

void main() {
  runApp(const SimpleTodoList());
}

class SimpleTodoList extends StatelessWidget {
  const SimpleTodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodosView(),
    );
  }
}
