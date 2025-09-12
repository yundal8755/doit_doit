import 'package:doit_doit/app/style/app_asset.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_shadow.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:doit_doit/app/util/app_date.dart';
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/presentation/component/button/base_button.dart';
import 'package:doit_doit/presentation/widget/common/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final String status;
  final String? description;
  final DateTime? dueDate;
  final VoidCallback? onPressed;

  const TodoCard({
    super.key,
    required this.title,
    required this.status,
    this.onPressed,
    this.description,
    this.dueDate,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: BaseButton(
                  onPressed: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(AppAsset.checkboxEmptyIcon,
                          width: 28.w, height: 28.w),
                      Gap(12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppTextStyle.semi1828
                                .copyWith(color: AppColor.gray900),
                          ),
                          const Gap(4),
                          if (description != null)
                            Text(
                              description!,
                              style: AppTextStyle.med1421
                                  .copyWith(color: AppColor.gray600),
                            ),
                          if (dueDate != null)
                            Column(
                              children: [
                                const Gap(4),
                                Text(
                                  '마감일 : ${AppDate.yyyyMMddW(dueDate!)} 까지',
                                  style: AppTextStyle.med1216
                                      .copyWith(color: AppColor.error400),
                                ),
                              ],
                            )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BaseButton(
                onPressed: () {
                  AppLog.d('더보기 클릭');
                },
                child: Padding(
                    padding: EdgeInsets.fromLTRB(12.w, 8.h, 0, 12.h),
                    child: SvgPicture.asset(AppAsset.moreVerticalIcon))),
          ],
        ),
      ),
    );
  }
}
