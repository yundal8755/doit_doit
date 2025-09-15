import 'package:firebase_auth/firebase_auth.dart';
import 'package:doit_doit/app/di/todo_di.dart';
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/feature/todo/entity/todo_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'fetch_todo_provider.g.dart';

@riverpod
class FetchTodo extends _$FetchTodo {
  @override
  Future<List<TodoEntity?>> build() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw Exception('로그인이 필요합니다.');
    }
    final result = await ref.read(fetchTodoListUsecaseProvider).call(uid);
    return result.fold(
      onSuccess: (entities) => entities,
      onFailure: (e) {
        AppLog.e(e);
        throw e;
      },
    );
  }

  Future<void> refresh() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      state = AsyncError(Exception('로그인이 필요합니다.'), StackTrace.current);
      return;
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(fetchTodoListUsecaseProvider).call(uid);
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
