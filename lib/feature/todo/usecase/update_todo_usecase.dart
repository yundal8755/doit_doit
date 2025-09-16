import 'package:doit_doit/app/module/error_handling/result.dart';
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/feature/todo/model/todo_model.dart';
import 'package:doit_doit/feature/todo/repository/todo_repository.dart';

class UpdateTodoUsecase {
  const UpdateTodoUsecase(this._repository);

  final TodoRepository _repository;

  Future<Result<void>> call({required TodoModel model}) async {
    AppLog.d('UpdateTodoUsecase');

    final result = await _repository.updateTodo(model: model);
    return result;
  }
}
