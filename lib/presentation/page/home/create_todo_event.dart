import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/feature/todo/model/todo_model.dart';
import 'package:doit_doit/presentation/provider/todo/create_todo_provider.dart';
import 'package:doit_doit/presentation/state/todo_form_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

mixin class CreateTodoEvent {
  ///
  /// 새 할 일 생성 상태 리스너
  ///
  void initCreateTodoListeners(WidgetRef ref) {
    AppLog.i('todo listener 실행!');

    ref.listen<AsyncValue<void>>(createTodoProvider, (prev, next) async {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if ((prev?.isLoading ?? false) && next.hasValue) {
          ScaffoldMessenger.of(ref.context)
              .showSnackBar(const SnackBar(content: Text('작업이 추가되었어요!')));
          ref.context.pop(true);
        }
      });

      // 에러 처리
      if (next.hasError) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if ((prev?.isLoading ?? false) && next.hasValue) {
            ScaffoldMessenger.of(ref.context).showSnackBar(
              SnackBar(content: Text('추가에 실패했어요: ${next.error}')),
            );
          }
        });
      }
    });
  }

  ///
  /// 작업 추가하기 버튼 클릭시
  ///
  Future<void> onTapCreateBtn(
    WidgetRef ref,
    TodoFormState state,
  ) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      AppLog.e('User not logged in');
      return;
    }
    final request = TodoModel(
      title: state.title,
      description: state.description,
      priority: state.priority,
      status: state.status,
    );

    await ref
        .read(createTodoProvider.notifier)
        .submit(userId: userId, model: request);
  }
}
