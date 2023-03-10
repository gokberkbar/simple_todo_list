import 'package:dio/dio.dart';
import 'package:simple_todo_list/data/dto/request/create_todo_request.dart';
import 'package:simple_todo_list/data/dto/response/create_todo_response.dart';
import 'package:simple_todo_list/models/todo.dart';

class DioClient {
  static final DioClient instance = DioClient._();

  final Dio _client = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com/',
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  DioClient._();

  Future<List<Todo>> getTodos() async {
    final response = await _client.get('users/1/todos');

    final List<dynamic> data = response.data;
    return data.map((dynamic json) => Todo.fromJson(json)).toList();
  }

  Future<void> deleteTodo(int id) {
    return _client.delete('todos/$id');
  }

  Future<Todo> createNewTodo(String title) async {
    final response = await _client.post(
      'todos',
      data: CreateTodoRequest(title: title),
    );

    final createTodoResponse = CreateTodoResponse.fromJson(response.data);
    return Todo(
      userId: 1,
      id: createTodoResponse.id,
      title: title,
      completed: false,
    );
  }
}
