import 'package:doit_doit/app/style/app_asset.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_shadow.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/feature/todo/model/todo_model.dart';
import 'package:doit_doit/presentation/widget/component/button/base_button.dart';
import 'package:doit_doit/presentation/widget/common/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class TodoCard extends StatelessWidget {
  final TodoModel model;
  final VoidCallback onPressed;

  const TodoCard({
    super.key,
    required this.model,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const badgeBackgroundColor = Colors.blue;

    AppLog.d(model.toString());

    return BaseButton(
      onPressed: onPressed,
      child: RoundedContainer(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 4.w),
        borderColor: AppColor.gray200,
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: AppShadow.firstShadow(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 체크박스
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.fromLTRB(0, 0, 12.w, 24.h),
              child: SvgPicture.asset(
                AppAsset.checkboxEmptyIcon,
                width: 28.w,
                height: 28.w,
              ),
            ),

            // 본문
            Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style:
                        AppTextStyle.semi1828.copyWith(color: AppColor.gray900),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(4),
                  if (model.description != null &&
                      model.description!.isNotEmpty) ...[
                    Text(
                      model.description!,
                      style: AppTextStyle.med1421
                          .copyWith(color: AppColor.gray600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(4),
                  ],
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: badgeBackgroundColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      model.priority,
                      style: AppTextStyle.med1216.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
