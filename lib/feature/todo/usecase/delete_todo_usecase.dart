import 'package:doit_doit/app/module/error_handling/result.dart';
import 'package:doit_doit/feature/todo/repository/todo_repository.dart';

class DeleteTodoUsecase {
  const DeleteTodoUsecase(this._repository);

  final TodoRepository _repository;

  Future<Result<void>> call({required String todoId}) async {
    final result = await _repository.deleteTodo(todoId: todoId);
    return result;
  }
}
