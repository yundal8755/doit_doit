import 'package:doit_doit/app/style/app_asset.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:doit_doit/feature/todo/model/todo_model.dart';
import 'package:doit_doit/presentation/provider/todo/fetch_todo_provider.dart';
import 'package:doit_doit/presentation/provider/todo/update_is_complete_provider.dart';
import 'package:doit_doit/presentation/widget/common/custom_end_action_pane.dart';
import 'package:doit_doit/presentation/page/home/todo_state.dart';
import 'package:doit_doit/presentation/widget/base/base_page.dart';
import 'package:doit_doit/presentation/widget/common/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CompletePage extends ConsumerWidget with TodoState {
  const CompletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BasePage(
      appbar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: Colors.transparent,
        title: SvgPicture.asset(AppAsset.logo, height: 24.h),
      ),
      child: fetchAsync(ref).when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('에러: $e')),
        data: (buckets) {
          final todoList = buckets.completed;

          if (todoList.isEmpty) {
            return Center(
              child: Text(
                '완료한 할 일이 없습니다.',
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

              final todoModel = TodoModel(
                id: todo.id,
                title: todo.title,
                description: todo.description,
                priority: todo.priority,
                isComplete: todo.isComplete,
              );

              return Slidable(
                key: ValueKey(todo.id),
                endActionPane: buildEndActionPane(context, ref, todoModel),
                child: StatefulBuilder(
                  builder: (context, setInnerState) {
                    return TodoCard(
                      model: todoModel,
                      onTapped: (updatedModel) async {
                        final toggled = todoModel.copyWith(
                            isComplete: !todoModel.isComplete);
                        await ref
                            .read(updateIsCompleteProvider.notifier)
                            .update(model: toggled);
                        ref.invalidate(fetchTodoProvider);

                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text('${todo.title}을 할 일로 옮겼습니다😊')),
                        // );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
