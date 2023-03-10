import 'package:equatable/equatable.dart';

class CreateTodoResponse extends Equatable {
  final int id;

  const CreateTodoResponse({
    required this.id,
  });

  CreateTodoResponse copyWith({
    int? id,
  }) {
    return CreateTodoResponse(
      id: id ?? this.id,
    );
  }

  factory CreateTodoResponse.fromJson(Map<String, dynamic> json) {
    return CreateTodoResponse(
      id: json['id'].toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }

  @override
  String toString() => '''CreateTodoResponse(id: $id)''';

  @override
  List<Object> get props => [id];
}
