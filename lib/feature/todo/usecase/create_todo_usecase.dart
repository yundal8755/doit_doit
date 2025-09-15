import 'package:doit_doit/app/module/error_handling/result.dart';
import 'package:doit_doit/feature/todo/model/todo_model.dart';
import 'package:doit_doit/feature/todo/repository/todo_repository.dart';

class CreateTodoUsecase {
  const CreateTodoUsecase(this._repository);

  final TodoRepository _repository;
  Future<Result<void>> call(
      {required String userId, required TodoModel request}) async {
    final result =
        await _repository.createTodo(userId: userId, request: request);
    return result;
  }
}
