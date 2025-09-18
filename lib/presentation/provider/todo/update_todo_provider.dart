import 'package:doit_doit/app/di/todo_di.dart';
import 'package:doit_doit/app/module/error_handling/result.dart';
import 'package:doit_doit/feature/todo/model/todo_model.dart';
import 'package:doit_doit/presentation/provider/todo/fetch_todo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_todo_provider.g.dart';

@riverpod
class UpdateTodo extends _$UpdateTodo {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<Result<void>> update({
    required TodoModel model,
  }) async {
    state = const AsyncLoading();
    try {
      final usecase = ref.read(updateTodoUsecaseProvider);
      final result = await usecase(model: model);

      result.fold(
        onSuccess: (_) {
          // 리스트 재로딩
          ref.read(fetchTodoProvider.notifier).refresh();

          state = const AsyncData(null);
        },
        onFailure: (e) => state = AsyncError(e, StackTrace.current),
      );
      return result;
    } catch (e, st) {
      state = AsyncError(e, st);
      return Result.failure(Exception(e.toString()));
    }
  }
}
