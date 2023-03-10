import 'package:flutter/material.dart';

import '../../../application/core/view_model_builder.dart';
import '../../../models/todo.dart';
import '../../widgets/todo_list_tile.dart';
import 'todos_view_model.dart';

class TodosView extends StatelessWidget {
  const TodosView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodosViewModel>(
      initViewModel: () => TodosViewModel(),
      builder: (context, viewModel) => Scaffold(
        appBar: AppBar(
          title: const Text('Todos'),
          actions: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: IconButton(
                key: ValueKey(viewModel.showCreateNewTodoField),
                splashRadius: 20,
                icon: Icon(
                  viewModel.showCreateNewTodoField ? Icons.close : Icons.add,
                ),
                onPressed: viewModel.toggleCreateNewTodoField,
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            viewModel.getTodos(showLoading: false);
          },
          child: SizedBox.expand(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  if (viewModel.showCreateNewTodoField)
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      child: SizedBox(
                        height: viewModel.showCreateNewTodoField ? null : 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: viewModel.controller,
                                  focusNode: viewModel.createTodoFocusNode,
                                  decoration: InputDecoration(
                                    hintText: 'Create new todo',
                                    isDense: true,
                                    suffix: IconButton(
                                      onPressed: viewModel.createTodo,
                                      icon: const Icon(
                                        Icons.done,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (viewModel.todos.isEmpty) ...[
                    const SizedBox(
                      height: 12,
                    ),
                    const Text('No todos found'),
                  ] else
                    ListView.separated(
                      itemCount: viewModel.todos.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final Todo todo = viewModel.todos[index];
                        return TodoListTile(
                          key: ValueKey(todo.id),
                          todo: todo,
                          onChanged: viewModel.onTodoStatusChanged,
                          onDeletePressed: viewModel.onTodoDeleted,
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
