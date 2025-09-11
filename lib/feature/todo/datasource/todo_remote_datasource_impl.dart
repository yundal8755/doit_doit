import 'package:doit_doit/feature/todo/datasource/todo_remote_datasource.dart';
import 'package:doit_doit/feature/todo/datasource/todo_remote_ref.dart';
import 'package:doit_doit/feature/todo/dto/todo_dto.dart';

final class TodoRemoteDatasourceImpl implements TodoRemoteDatasource {
  // TODO : 페이징 처리 필요
  @override
  Future<List<TodoDto?>> fetchTodoList(String userId) async {
    final snapshot = await FirestoreTodosRef.collection(userId).get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
