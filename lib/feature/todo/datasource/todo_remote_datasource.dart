import 'package:doit_doit/feature/todo/dto/todo_dto.dart';

abstract interface class TodoRemoteDatasource {
  ///
  /// 전체 할 일 목록 조회
  ///
  Future<List<TodoDto?>> fetchTodoList(String userId);
}
