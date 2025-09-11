import 'package:doit_doit/app/di/todo_di.dart';
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/feature/todo/entity/todo_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_provider.g.dart';

@riverpod
class Todo extends _$Todo {
  @override
  FutureOr<List<TodoEntity?>> build(String userId) async {
    try {
      final result = await ref.read(fetchTodoListUsecaseProvider).call(userId);
      return result.fold(
        onSuccess: (entities) => entities, // ✅ List<TodoEntity> 반환
        onFailure: (e) {
          AppLog.e(e);
          throw e; // throw → AsyncError
        },
      );
    } catch (e) {
      AppLog.e(e);
      rethrow;
    }
  }

  // 새로고침/재요청이 필요할 때 호출용
  Future<void> refresh(String userId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(fetchTodoListUsecaseProvider).call(userId);
      return result.fold(
        onSuccess: (entities) => entities,
        onFailure: (e) {
          AppLog.e(e);
          throw e;
        },
      );
    });
  }
}
