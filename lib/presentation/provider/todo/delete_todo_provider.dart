import 'package:doit_doit/app/di/todo_di.dart';
import 'package:doit_doit/app/module/error_handling/result.dart';
import 'package:doit_doit/presentation/provider/todo/fetch_todo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_todo_provider.g.dart';

@riverpod
class DeleteTodo extends _$DeleteTodo {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<Result<void>> submit({
    required String todoId,
  }) async {
    state = const AsyncLoading();
    try {
      final usecase = ref.read(deleteTodoUsecaseProvider);
      final result = await usecase(todoId: todoId);

      result.fold(
        onSuccess: (_) {
          // 리스트 재로딩
          ref.invalidate(fetchTodoProvider);

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
