import 'package:doit_doit/app/router/router.dart';
import 'package:doit_doit/app/style/app_asset.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/presentation/component/button/base_button.dart';
import 'package:doit_doit/presentation/provider/todo/todo_provider.dart';
import 'package:doit_doit/presentation/widget/base/base_page.dart';
import 'package:doit_doit/presentation/widget/common/rounded_container.dart';
import 'package:doit_doit/presentation/widget/common/todo_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class OnGoingPage extends ConsumerWidget {
  const OnGoingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return const Center(child: Text('로그인이 필요합니다.'));
    }

    final todosAsync = ref.watch(todoProvider(currentUser.uid));

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
          backgroundColor: AppColor.primary600,
          padding: const EdgeInsets.all(16),
          child: SvgPicture.asset(AppAsset.plusIcon),
        ),
      ),
      child: todosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('에러: $e')),
        data: (todos) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(16),
              _buildSectionGuide(
                  title: '긴급', todoLength: todos.length, onPressed: () {}),
              const Gap(16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];

                  if (todos.isEmpty) {
                    return const Center(child: Text('진행 중인 할 일이 없습니다.'));
                  }

                  if (todo == null) {
                    return const SizedBox.shrink();
                  }

                  return TodoCard(
                    title: todo.title,
                    status: todo.status,
                    description: todo.description,
                    dueDate: todo.dueDate,
                    onPressed: () => AppLog.d('${todo.title} 눌렀습니다!'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionGuide({
    required String title,
    required int todoLength,
    required VoidCallback onPressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$title ($todoLength)',
            style: AppTextStyle.semi1828.copyWith(color: AppColor.gray900)),
        BaseButton(
          onPressed: onPressed,
          child: Text('전체보기',
              style: AppTextStyle.med1421.copyWith(color: AppColor.primary500)),
        ),
      ],
    );
  }
}
