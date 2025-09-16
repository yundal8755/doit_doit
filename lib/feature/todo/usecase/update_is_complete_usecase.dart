import 'package:doit_doit/app/module/error_handling/result.dart';
import 'package:doit_doit/feature/todo/model/todo_model.dart';
import 'package:doit_doit/feature/todo/repository/todo_repository.dart';

class UpdateIsCompleteUsecase {
  const UpdateIsCompleteUsecase(this._repository);

  final TodoRepository _repository;

  Future<Result<void>> call({required TodoModel model}) async {
    final result = await _repository.updateIsComplete(model: model);
    return result;
  }
}
