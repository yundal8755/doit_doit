import 'package:doit_doit/app/style/app_asset.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:doit_doit/app/util/app_date.dart';
import 'package:doit_doit/feature/todo/model/todo_model.dart';
import 'package:doit_doit/presentation/widget/component/button/base_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class TodoCard extends StatefulWidget {
  final TodoModel model;
  final ValueChanged<TodoModel> onTapped;

  const TodoCard({
    super.key,
    required this.model,
    required this.onTapped,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  late TodoModel currentModel;

  @override
  void initState() {
    super.initState();
    currentModel = widget.model;
  }

  bool get _isCompleted => currentModel.isComplete;

  @override
  Widget build(BuildContext context) {
    final accent = _priorityAccent(currentModel.priority);

    return BaseButton(
      onPressed: () {
        // 햅틱 피드백
        HapticFeedback.selectionClick();
        setState(() {
          currentModel = currentModel.copyWith(
            isComplete: !currentModel.isComplete,
          );
        });

        widget.onTapped(currentModel);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeOut,
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 4.w),
            decoration: BoxDecoration(
              color: _isCompleted ? Colors.grey.shade50 : AppColor.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.gray200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 체크박스
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.fromLTRB(0, 0, 12.w, 24.h),
                  child: SvgPicture.asset(
                    _isCompleted
                        ? AppAsset.checkboxCheckedIcon
                        : AppAsset.checkboxEmptyIcon,
                    width: 28.w,
                    height: 28.w,
                  ),
                ),

                // 내용
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 제목
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 180),
                        style: AppTextStyle.semi1828.copyWith(
                          color: _isCompleted
                              ? AppColor.gray500
                              : AppColor.gray900,
                          decoration:
                              _isCompleted ? TextDecoration.lineThrough : null,
                          decorationThickness: 1.4,
                          decorationColor: AppColor.gray400,
                        ),
                        child: Text(
                          currentModel.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Gap(4),

                      // 설명
                      if (currentModel.description != null &&
                          currentModel.description!.isNotEmpty) ...[
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 180),
                          style: AppTextStyle.med1421.copyWith(
                            color: _isCompleted
                                ? AppColor.gray500
                                : AppColor.gray600,
                          ),
                          child: Text(
                            currentModel.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Gap(6),
                      ],

                      // 하단 라벨
                      Row(
                        children: [
                          _priorityChip(currentModel.priority,
                              filled: !_isCompleted),
                          Gap(8.w),
                          Icon(Icons.schedule,
                              size: 14.w, color: AppColor.gray400),
                          SizedBox(width: 4.w),
                          Text(
                            AppDate.yyyyMMddW(currentModel.createdAt),
                            style: AppTextStyle.med1216
                                .copyWith(color: AppColor.gray500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 좌측 상태 스트라이프
          Positioned.fill(
            left: 0,
            child: IgnorePointer(
              child: Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  width: 3.w,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: _isCompleted ? AppColor.gray200 : accent,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// 우선순위 컬러
  ///
  Color _priorityAccent(String priority) {
    switch (priority) {
      case '긴급':
        return AppColor.error400;
      case '중요':
        return const Color(0xFFF59E0B);
      case '보통':
        return AppColor.success500;
      case '낮음':
        return AppColor.gray300;
      default:
        return AppColor.gray300;
    }
  }

  ///
  /// 우선순위 배지
  ///
  Widget _priorityChip(String priority, {required bool filled}) {
    final accent = _priorityAccent(priority);
    final bg = filled ? accent.withOpacity(0.14) : Colors.transparent;
    final border = filled ? Colors.transparent : accent.withOpacity(0.12);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: border),
      ),
      child: Text(
        priority,
        style: AppTextStyle.med1216.copyWith(color: accent),
      ),
    );
  }
}
