import 'package:doit_doit/feature/todo/model/create_todo_model.dart';
import 'package:doit_doit/feature/todo/model/todo_dto.dart';

abstract interface class TodoRemoteDatasource {
  ///
  /// 전체 할 일 목록 조회
  ///
  Future<List<TodoDto?>> fetchTodoList(String userId);

  ///
  /// 할 일 추가
  ///
  Future<void> createTodo(
      {required String userId, required CreateTodoModel request});
}
