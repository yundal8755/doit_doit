import 'package:doit_doit/feature/todo/datasource/todo_remote_datasource.dart';
import 'package:doit_doit/feature/todo/datasource/todo_remote_ref.dart';
import 'package:doit_doit/feature/todo/model/create_todo_model.dart';
import 'package:doit_doit/feature/todo/model/todo_dto.dart';

final class TodoRemoteDatasourceImpl implements TodoRemoteDatasource {
  // TODO : 페이징 처리 필요
  @override
  Future<List<TodoDto?>> fetchTodoList(String userId) async {
    final snapshot = await FirestoreTodosRef.collection(userId).get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<void> createTodo(
      {required String userId, required CreateTodoModel request}) {
    return FirestoreTodosRef.create(userId: userId, request: request);
  }
}
