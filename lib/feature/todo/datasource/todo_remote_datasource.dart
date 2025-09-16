import 'package:doit_doit/feature/todo/model/todo_model.dart';

abstract interface class TodoRemoteDatasource {
  ///
  /// 전체 할 일 목록 조회
  ///
  Future<List<TodoModel?>> fetchTodoList(String userId);

  ///
  /// 할 일 추가
  ///
  Future<void> createTodo({required String userId, required TodoModel request});

  ///
  /// 할 일 삭제
  ///
  Future<void> deleteTodo({required String todoId});

  ///
  /// 할 일 업데이트
  ///
  Future<void> updateTodo({required TodoModel model});
}
