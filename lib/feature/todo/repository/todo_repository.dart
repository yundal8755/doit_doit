import 'package:doit_doit/app/module/error_handling/result.dart';
import 'package:doit_doit/feature/todo/entity/todo_entity.dart';

abstract interface class TodoRepository {
  ///
  /// 할일 목록 조회
  ///
  Future<Result<List<TodoEntity?>>> fetchTodoList(String userId);
}
