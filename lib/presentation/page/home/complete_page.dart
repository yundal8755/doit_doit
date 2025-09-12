import 'package:doit_doit/app/router/router.dart';
import 'package:doit_doit/app/style/app_asset.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/presentation/component/button/base_button.dart';
import 'package:doit_doit/presentation/widget/base/base_page.dart';
import 'package:doit_doit/presentation/widget/common/rounded_container.dart';
import 'package:doit_doit/presentation/widget/common/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CompletePage extends ConsumerWidget {
  const CompletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 임시 데이터
    final projects = List.generate(
      30,
      (index) => {
        "title": "프로젝트 ${index + 1}",
        "percent": (index + 1) * 10 % 100,
        "remaining": (index + 1) * 2,
      },
    );

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
                child: SvgPicture.asset(
                  AppAsset.userIcon,
                ),
              ),
            ),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 긴급 작업
            _buildSectionGuide(
              title: '긴급 작업',
              onPressed: () {},
            ),
            const Gap(16),

            /// 📌 ListView -> Column처럼 동작하도록 수정
            // ListView.builder(
            //   shrinkWrap: true, // 자식 개수만큼 높이 차지
            //   physics: const NeverScrollableScrollPhysics(), // 스크롤 비활성화
            //   itemCount: projects.length,
            //   itemBuilder: (context, index) {
            //     final project = projects[index];
            //     return TodoCard(

            //       title: project["title"] as String,
            //       onPressed: () {
            //         AppLog.d('눌렀습니다!');
            //       },
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionGuide({
    required String title,
    required VoidCallback onPressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.semi1828.copyWith(color: AppColor.gray900),
        ),
        // BaseButton(
        //   onPressed: onPressed,
        //   child: Text(
        //     '전체보기',
        //     style: AppTextStyle.med1421.copyWith(color: AppColor.primary500),
        //   ),
        // ),
      ],
    );
  }
}
