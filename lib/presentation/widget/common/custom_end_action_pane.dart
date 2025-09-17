import 'package:doit_doit/app/router/router.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:doit_doit/feature/todo/model/todo_model.dart';
import 'package:doit_doit/presentation/provider/todo/delete_todo_provider.dart';
import 'package:doit_doit/presentation/provider/todo/fetch_todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

///
/// 커스텀 액션 패인 빌드
///
ActionPane buildEndActionPane(
    BuildContext context, WidgetRef ref, TodoModel todo) {
  return ActionPane(
    motion: const DrawerMotion(),
    children: [
      CustomSlidableAction(
        onPressed: (_) => context.push(AppRoute.edit.path, extra: todo),
        backgroundColor: AppColor.gray600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.edit, color: Colors.white),
            Gap(4.h),
            Text("수정",
                style: AppTextStyle.med1421.copyWith(color: Colors.white)),
          ],
        ),
      ),
      CustomSlidableAction(
        onPressed: (_) async {
          await ref
              .read(deleteTodoProvider.notifier)
              .delete(todoId: todo.id ?? '');
          ref.invalidate(fetchTodoProvider);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('할 일을 삭제했습니다🥲')),
          );
        },
        backgroundColor: AppColor.error400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.delete, color: Colors.white),
            Gap(4.h),
            Text("삭제",
                style: AppTextStyle.med1421.copyWith(color: Colors.white)),
          ],
        ),
      ),
    ],
  );
}
