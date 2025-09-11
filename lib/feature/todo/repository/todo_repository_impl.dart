import 'package:doit_doit/app/module/error_handling/result.dart';
import 'package:doit_doit/feature/todo/datasource/todo_remote_datasource.dart';
import 'package:doit_doit/feature/todo/entity/todo_entity.dart';
import 'package:doit_doit/feature/todo/repository/todo_repository.dart';

final class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDatasource _remote;

  TodoRepositoryImpl(this._remote);

  @override
  Future<Result<List<TodoEntity?>>> fetchTodoList(String userId) async {
    try {
      final dtoList = await _remote.fetchTodoList(userId);
      final entityList = dtoList.map((dto) => dto?.toEntity()).toList();
      return Result.success(entityList);
    } catch (e) {
      return Result.failure(Exception('$e'));
    }
  }
}
