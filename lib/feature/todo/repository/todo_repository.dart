import 'package:doit_doit/app/module/error_handling/result.dart';
import 'package:doit_doit/feature/todo/entity/todo_entity.dart';
import 'package:doit_doit/feature/todo/model/todo_model.dart';

abstract interface class TodoRepository {
  ///
  /// 할일 목록 조회
  ///
  Future<Result<List<TodoEntity?>>> fetchTodoList(String userId);

  ///
  /// 할 일 추가
  ///
  Future<Result<void>> createTodo(
      {required String userId, required TodoModel request});

  ///
  /// 할 일 삭제
  ///
  Future<Result<void>> deleteTodo({required String todoId});

  ///
  /// 할 일 업데이트
  ///
  Future<Result<void>> updateTodo({required TodoModel model});

  ///
  /// 진행중/완료 토글 업데이트
  ///
  Future<Result<void>> updateIsComplete({required TodoModel model});
}
