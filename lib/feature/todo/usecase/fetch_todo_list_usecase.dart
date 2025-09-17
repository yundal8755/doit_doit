import 'package:doit_doit/app/module/error_handling/result.dart';
import 'package:doit_doit/app/util/app_typedef.dart';
import 'package:doit_doit/feature/todo/entity/todo_entity.dart';
import 'package:doit_doit/feature/todo/repository/todo_repository.dart';

class FetchTodoListUsecase {
  const FetchTodoListUsecase(this._repository);
  final TodoRepository _repository;

  /// 우선순위: 높을수록 큰 수
  int _priorityRank(String? p) {
    switch (p) {
      case '긴급':
        return 4;
      case '중요':
        return 3;
      case '보통':
        return 2;
      case '낮음':
        return 1;
      default:
        return 0;
    }
  }

  /// 진행중 정렬
  int _compareOngoing(TodoEntity? a, TodoEntity? b) {
    final ar = _priorityRank(a?.priority);
    final br = _priorityRank(b?.priority);
    if (ar != br) return br.compareTo(ar); // 우선순위 높은 순서

    final ax = a?.createdAt;
    final bx = b?.createdAt;
    if (ax == null || bx == null) return 0;
    return bx.compareTo(ax); // 최신 생성
  }

  /// 완료 정렬
  int _compareCompleted(TodoEntity? a, TodoEntity? b) {
    final ar = _priorityRank(a?.priority);
    final br = _priorityRank(b?.priority);
    if (ar != br) return br.compareTo(ar); // 우선순위 높은 순서

    final ax = a?.completedAt ?? a?.createdAt;
    final bx = b?.completedAt ?? b?.createdAt;
    if (ax == null || bx == null) return 0;
    return bx.compareTo(ax); // 최신 생성
  }

  Future<Result<TodoBuckets>> call(String userId) async {
    final res = await _repository.fetchTodoList(userId);
    return res.fold(
      onSuccess: (list) {
        final ongoing = <TodoEntity?>[];
        final completed = <TodoEntity?>[];

        for (final e in list) {
          (e?.isComplete == true ? completed : ongoing).add(e);
        }

        ongoing.sort(_compareOngoing);
        completed.sort(_compareCompleted);

        return Result.success((ongoing: ongoing, completed: completed));
      },
      onFailure: (e) => Result.failure(e),
    );
  }
}
