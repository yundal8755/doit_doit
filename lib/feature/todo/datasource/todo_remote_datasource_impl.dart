import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/feature/todo/datasource/todo_remote_datasource.dart';
import 'package:doit_doit/feature/todo/datasource/todo_remote_ref.dart';
import 'package:doit_doit/feature/todo/model/todo_model.dart';

final class TodoRemoteDatasourceImpl implements TodoRemoteDatasource {
  // TODO : 페이징 처리 필요
  @override
  Future<List<TodoModel?>> fetchTodoList(String userId) async {
    final snapshot = await FirestoreTodosRef.collection(userId).get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<void> createTodo(
      {required String userId, required TodoModel request}) {
    return FirestoreTodosRef.create(userId: userId, request: request);
  }

  @override
  Future<void> deleteTodo({required String todoId}) {
    return FirestoreTodosRef.delete(todoId: todoId);
  }

  @override
  Future<void> updateTodo({required TodoModel model}) {
    AppLog.d('updateTodo');
    return FirestoreTodosRef.update(model: model);
  }
}
