// lib/presentation/page/todo/create_todo_page.dart
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/presentation/component/button/base_button.dart';
import 'package:doit_doit/presentation/component/drop_down/cool_drop_down.dart';
import 'package:doit_doit/presentation/component/form_field/cool_form_field_widget.dart';
import 'package:doit_doit/presentation/widget/base/base_page.dart';
import 'package:doit_doit/presentation/widget/common/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CreateTodoPage extends ConsumerStatefulWidget {
  const CreateTodoPage({super.key});

  @override
  ConsumerState<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends ConsumerState<CreateTodoPage> {
  String? selectedItem;
  bool isStatusOnGoing = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey buttonKey = GlobalKey();
    final List<String> priority = ['긴급', '중요', '보통', '낮음'];

    return BasePage(
      appbar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text('새 작업 추가'),
      ),
      child: Column(
        children: [
          CoolFormField(
            label: '작업 제목',
            hintText: '작업 제목을 입력해주세요',
            visualType: CoolFormFieldVisualType.outline,
            onChanged: (value) {
              setState(() {});
            },
          ),
          const Gap(24),
          CoolFormField(
            label: '작업 설명',
            hintText: '작업에 대한 설명을 입력해주세요',
            visualType: CoolFormFieldVisualType.outline,
            onChanged: (value) {
              setState(() {});
            },
          ),
          const Gap(12),
          //! 우선순위
          _buildFrameSection(
            title: '우선순위',
            child: Container(
              key: buttonKey,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.gray400),
              ),
              child: InkWell(
                onTap: () {
                  showCustomDropdown<String>(
                    context: context,
                    anchorKey: buttonKey,
                    items: priority,
                    onItemSelected: (value) {
                      setState(() {
                        selectedItem = value;
                      });
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedItem ?? priority[0],
                        style: AppTextStyle.med1421.copyWith(
                          color: AppColor.gray900,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: AppColor.gray500,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          //! 진행상황
          _buildFrameSection(
            title: '진행상황',
            child: Row(
              children: [
                Expanded(
                  child: BaseButton(
                    onPressed: () {
                      setState(() {
                        isStatusOnGoing = true;
                        AppLog.d('isStatusOnGoing: $isStatusOnGoing');
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: isStatusOnGoing
                            ? AppColor.primary500
                            : AppColor.gray200,
                      ),
                      child: Center(
                          child: Text(
                        '진행중',
                        style: TextStyle(
                            color: isStatusOnGoing
                                ? AppColor.white
                                : AppColor.gray700),
                      )),
                    ),
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: BaseButton(
                    onPressed: () {
                      setState(() {
                        isStatusOnGoing = false;
                        AppLog.d('isStatusOnGoing: $isStatusOnGoing');
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: isStatusOnGoing
                            ? AppColor.gray200
                            : AppColor.primary500,
                      ),
                      child: Center(
                        child: Text(
                          '완료',
                          style: TextStyle(
                              color: isStatusOnGoing
                                  ? AppColor.gray700
                                  : AppColor.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //! 마감날짜

          const Spacer(),
          BaseButton(
            onPressed: () {},
            child: RoundedContainer(
              backgroundColor: AppColor.primary500,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '작업 추가하기',
                    style: AppTextStyle.med1421.copyWith(
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(24),
        ],
      ),
    );
  }

  Widget _buildFrameSection({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.med1421.copyWith(
              color: AppColor.gray700,
            ),
          ),
          const Gap(8),
          child,
        ],
      ),
    );
  }
}
