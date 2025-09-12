import 'package:doit_doit/app/di/todo_di.dart';
import 'package:doit_doit/app/module/error_handling/result.dart';
import 'package:doit_doit/feature/todo/model/create_todo_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_todo_provider.g.dart';

/// 버튼 탭 → 제출 중 로딩/성공/에러를 표현
@riverpod
class CreateTodoProvider extends _$CreateTodoProvider {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<Result<void>> submit({
    required String userId,
    required CreateTodoModel request,
  }) async {
    state = const AsyncLoading();
    try {
      final usecase = ref.read(createTodoUsecaseProvider);
      final result = await usecase(userId: userId, request: request);
      result.fold(
        onSuccess: (_) => state = const AsyncData(null),
        onFailure: (e) => state = AsyncError(e, StackTrace.current),
      );
      return result;
    } catch (e, st) {
      state = AsyncError(e, st);
      return Result.failure(Exception(e.toString()));
    }
  }
}
