import 'package:flutter/material.dart';

import '../../../application/core/base_view_model.dart';
import '../../../data/remote/dio_client.dart';
import '../../../models/todo.dart';

class TodosViewModel extends BaseViewModel {
  List<Todo> todos = [];
  bool showCreateNewTodoField = false;
  FocusNode createTodoFocusNode = FocusNode();
  TextEditingController controller = TextEditingController();

  @override
  void onBindingCreated() {
    getTodos();
    super.onBindingCreated();
  }

  void toggleCreateNewTodoField() {
    showCreateNewTodoField = !showCreateNewTodoField;
    controller.clear();
    if (showCreateNewTodoField) {
      createTodoFocusNode.requestFocus();
    }
    notifyListeners();
  }

  Future<void> getTodos({bool showLoading = true}) async {
    flow(
      () async {
        todos = await DioClient.instance.getTodos();
      },
      showLoading: showLoading,
    );
  }

  Future<void> onTodoDeleted(Todo todo) async {
    flow(() async {
      await DioClient.instance.deleteTodo(todo.id);
      todos.remove(todo);
    });
  }

  Future<void> createTodo() async {
    flow(() async {
      final todo = await DioClient.instance.createNewTodo(controller.text);
      todos.insert(0, todo);
      toggleCreateNewTodoField();
    });
  }

  void onTodoStatusChanged(bool value, Todo todo) {
    if (todos.contains(todo)) {
      final int index = todos.indexOf(todo);
      todos[index] = todo.copyWith(completed: value);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    createTodoFocusNode.dispose();
    controller.dispose();
    super.dispose();
  }
}
