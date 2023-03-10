import 'package:equatable/equatable.dart';

class CreateTodoRequest extends Equatable {
  final String title;

  const CreateTodoRequest({
    required this.title,
  });

  CreateTodoRequest copyWith({
    String? title,
  }) {
    return CreateTodoRequest(
      title: title ?? this.title,
    );
  }

  factory CreateTodoRequest.fromJson(Map<String, dynamic> json) {
    return CreateTodoRequest(
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
    };
  }

  @override
  String toString() => '''CreateTodoRequest(title: $title)''';

  @override
  List<Object> get props => [title];
}
