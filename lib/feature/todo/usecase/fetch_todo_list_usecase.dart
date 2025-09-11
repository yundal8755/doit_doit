import 'package:doit_doit/app/module/error_handling/result.dart';
import 'package:doit_doit/feature/todo/entity/todo_entity.dart';
import 'package:doit_doit/feature/todo/repository/todo_repository.dart';

class FetchTodoListUsecase {
  const FetchTodoListUsecase(this._repository);

  final TodoRepository _repository;

  Future<Result<List<TodoEntity?>>> call(String userId) async {
    return _repository.fetchTodoList(userId);
  }
}
