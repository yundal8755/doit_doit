import 'package:doit_doit/app/router/router.dart';
import 'package:doit_doit/app/style/app_asset.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/feature/todo/model/todo_model.dart';
import 'package:doit_doit/presentation/provider/todo/delete_todo_provider.dart';
import 'package:doit_doit/presentation/widget/component/button/base_button.dart';
import 'package:doit_doit/presentation/page/home/todo_state.dart';
import 'package:doit_doit/presentation/widget/base/base_page.dart';
import 'package:doit_doit/presentation/widget/common/rounded_container.dart';
import 'package:doit_doit/presentation/widget/common/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OnGoingPage extends ConsumerWidget with TodoState {
  const OnGoingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BasePage(
      appbar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: Colors.transparent,
        title: SvgPicture.asset(AppAsset.logo, height: 24.h),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: BaseButton(
              onPressed: () => context.push(AppRoute.profile.path),
              child: CircleAvatar(
                backgroundColor: AppColor.primary500,
                child: SvgPicture.asset(AppAsset.userIcon),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: BaseButton(
        onPressed: () => context.push(AppRoute.create.path),
        child: RoundedContainer(
          backgroundColor: AppColor.primary500,
          padding: const EdgeInsets.all(16),
          child: SvgPicture.asset(AppAsset.plusIcon),
        ),
      ),
      child: fetchAsync(ref).when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('에러: $e')),
        data: (todoList) {
          AppLog.d('todo length: ${todoList.length}');

          if (todoList.isEmpty) {
            return Center(
              child: Text(
                '진행 중인 할 일이 없습니다.',
                style: AppTextStyle.med1421.copyWith(color: AppColor.gray600),
              ),
            );
          }

          return ListView.separated(
            itemCount: todoList.length,
            separatorBuilder: (context, index) => Gap(12.h),
            itemBuilder: (context, index) {
              final todo = todoList[index];
              if (todo == null) return const SizedBox.shrink();

              final docId = todo.id;
              AppLog.i('todo 정보 : $todo');

              return Slidable(
                key: ValueKey(docId),
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    // 수정
                    SlidableAction(
                      onPressed: (_) {
                        final todoModel = TodoModel(
                          id: todo.id,
                          title: todo.title,
                          description: todo.description,
                          priority: todo.priority,
                          isComplete: todo.isComplete,
                        );

                        context.push(AppRoute.edit.path, extra: todoModel);
                      },
                      backgroundColor: AppColor.gray600,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: '수정',
                    ),

                    // 삭제
                    SlidableAction(
                      onPressed: (_) async {
                        await ref
                            .read(deleteTodoProvider.notifier)
                            .delete(todoId: docId ?? '');
                      },
                      backgroundColor: AppColor.error400,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: '삭제',
                    ),
                  ],
                ),
                child: TodoCard(
                  title: todo.title,
                  description: todo.description,
                  onPressed: () => AppLog.d('${todo.title} 눌렀습니다!'),
                  priority: todo.priority,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
