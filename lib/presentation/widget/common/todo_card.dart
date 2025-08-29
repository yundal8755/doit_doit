import 'package:doit_doit/app/style/app_asset.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_shadow.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:doit_doit/presentation/component/button/base_button.dart';
import 'package:doit_doit/presentation/widget/common/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final int percent; // 진행률 (0~100)
  final int remainingTasks; // 남은 작업 개수
  final VoidCallback? onPressed;

  const TodoCard({
    super.key,
    required this.title,
    required this.percent,
    required this.remainingTasks,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onPressed: onPressed,
      child: RoundedContainer(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          borderColor: AppColor.gray200,
          decoration: BoxDecoration(
            color: AppColor.white,
            boxShadow: AppShadow.firstShadow(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SvgPicture.asset(AppAsset.checkboxEmptyIcon),
              Gap(12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        AppTextStyle.med1421.copyWith(color: AppColor.gray900),
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      RoundedContainer(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.w),
                          backgroundColor: AppColor.gray050,
                          child: Text('긴급',
                              style: AppTextStyle.med1216
                                  .copyWith(color: AppColor.error400))),
                      Gap(8.w),
                      Text(
                        '남은 작업 $remainingTasks',
                        style: AppTextStyle.med1216
                            .copyWith(color: AppColor.gray600),
                      ),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
