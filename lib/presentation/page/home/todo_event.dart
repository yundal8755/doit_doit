import 'dart:math';

import 'package:doit_doit/app/style/app_asset.dart';
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/feature/todo/model/todo_model.dart';
import 'package:doit_doit/presentation/provider/todo/create_todo_provider.dart';
import 'package:doit_doit/presentation/provider/todo/fetch_todo_provider.dart';
import 'package:doit_doit/presentation/provider/todo/update_is_complete_provider.dart';
import 'package:doit_doit/presentation/provider/todo/update_todo_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

mixin class TodoEvent {
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
  /// 할 일 업데이트 상태 리스너
  ///
  void updateTodoListeners(WidgetRef ref) {
    AppLog.i('todo listener 실행!');

    ref.listen<AsyncValue<void>>(updateTodoProvider, (prev, next) async {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if ((prev?.isLoading ?? false) && next.hasValue) {
          ScaffoldMessenger.of(ref.context)
              .showSnackBar(const SnackBar(content: Text('할 일이 수정되었어요!')));
          ref.context.pop(true);
        }
      });

      // 에러 처리
      if (next.hasError) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if ((prev?.isLoading ?? false) && next.hasValue) {
            ScaffoldMessenger.of(ref.context).showSnackBar(
              SnackBar(content: Text('수정에 실패했어요: ${next.error}')),
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
    TodoModel model,
  ) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      AppLog.e('User not logged in');
      return;
    }
    await ref
        .read(createTodoProvider.notifier)
        .create(userId: userId, model: model);
  }

  ///
  /// 수정하기 버튼 클릭시
  ///
  Future<void> onTapUpdateBtn(
    WidgetRef ref,
    TodoModel model,
  ) async {
    AppLog.d('onTapUpdateBtn');
    await ref.read(updateTodoProvider.notifier).update(model: model);
  }

  ///
  /// 할 일 카드 클릭시
  ///
  Future<void> onTappedTodoCard(
      BuildContext context, WidgetRef ref, TodoModel todoModel) async {
    final animations = [
      AppAsset.clapPenguin,
      AppAsset.clapSmoothman,
      AppAsset.completeCongratulation,
    ];

    final random = Random();
    final selectedAnimation = animations[random.nextInt(animations.length)];

    final messages = [
      "👏 잘했어요!",
      "🎉 멋지게 완료했네요!",
      "✅ 작업 완료!",
    ];
    final selectedMessage = messages[random.nextInt(messages.length)];

    await ref.read(updateIsCompleteProvider.notifier).update(model: todoModel);

    // 다이얼로그 표시
    if (!context.mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 240.w,
              height: 240.w,
              child: Lottie.asset(
                selectedAnimation,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              selectedMessage,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

    // 2초 후 다이얼로그 닫기
    await Future.delayed(const Duration(milliseconds: 1500));
    if (context.mounted) {
      context.pop();

      // 리스트 재로딩
      ref.invalidate(fetchTodoProvider);
    }
  }
}
