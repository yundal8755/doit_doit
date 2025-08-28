import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_shadow.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:doit_doit/presentation/widget/common/circlular_percent_indicator.dart';
import 'package:doit_doit/presentation/widget/common/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final int percent; // 진행률 (0~100)
  final int remainingTasks; // 남은 작업 개수

  const ProjectCard({
    super.key,
    required this.title,
    required this.percent,
    required this.remainingTasks,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(16.w),
      borderColor: AppColor.gray200,
      decoration: BoxDecoration(
        color: AppColor.white,
        boxShadow: AppShadow.firstShadow(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 프로젝트명
          Text(
            title,
            style: AppTextStyle.med1421.copyWith(color: AppColor.gray900),
          ),
          const Gap(8),

          /// 진행률 + 남은 작업
          Row(
            children: [
              CircularPercentIndicator(
                percent: percent.toDouble(), // 0~100 값
              ),
              Gap(40.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '남은 작업',
                    style:
                        AppTextStyle.med1421.copyWith(color: AppColor.gray600),
                  ),
                  Text(
                    '$remainingTasks',
                    style:
                        AppTextStyle.semi1828.copyWith(color: AppColor.gray900),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
