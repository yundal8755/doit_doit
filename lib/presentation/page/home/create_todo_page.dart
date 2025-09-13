// lib/presentation/page/todo/create_todo_page.dart
import 'package:doit_doit/app/style/app_asset.dart';
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/app/util/app_validator.dart';
import 'package:doit_doit/feature/todo/model/create_todo_model.dart';
import 'package:doit_doit/presentation/component/button/base_button.dart';
import 'package:doit_doit/presentation/component/drop_down/cool_drop_down.dart';
import 'package:doit_doit/presentation/component/form_field/cool_form_field_widget.dart';
import 'package:doit_doit/presentation/provider/todo/create_todo_provider.dart';
import 'package:doit_doit/presentation/provider/todo/todo_provider.dart';
import 'package:doit_doit/presentation/widget/base/base_page.dart';
import 'package:doit_doit/presentation/widget/common/rounded_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

///
/// 우선순위(Priority) 열거형
///
enum Priority {
  urgent(value: '긴급'),
  important(value: '중요'),
  normal(value: '보통'),
  low(value: '낮음');

  final String value;

  const Priority({required this.value});
}

///
/// Status 열거형
///
enum Status {
  ongoing(value: '진행 중'),
  completed(value: '완료');

  final String value;

  const Status({required this.value});
}

///
/// 새 할 일 생성 페이지
///
class CreateTodoPage extends ConsumerStatefulWidget {
  const CreateTodoPage({super.key});

  @override
  ConsumerState<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends ConsumerState<CreateTodoPage> {
  // 🔸 제목/설명 값은 상태로 보관
  String _title = '';
  String _description = '';
  DateTime? _dueDate;
  DateTime? _completedAt;

  String? _priorityText;
  bool isStatusOnGoing = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
// CreateTodoPage.build 안의 ref.listen 성공 분기
    ref.listen<AsyncValue<void>>(createTodoProvider, (prev, next) async {
      if ((prev?.isLoading ?? false) && next.hasValue) {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          // ✅ 최신 데이터 받아올 때까지 기다렸다가
          await ref.refresh(todoProvider(userId).future);
          //   - 또는 간단히: ref.invalidate(todoProvider(userId)); (바로 재요청 트리거)
        }

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('작업이 추가되었어요!')),
        );

        // ✅ 성공 신호와 함께 이전 화면으로
        Navigator.of(context).pop(true);
      }

      if (next.hasError) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('추가에 실패했어요: ${next.error}')),
        );
      }
    });

    final createState = ref.watch(createTodoProvider);
    final isSubmitting = createState.isLoading;
    final GlobalKey priorityKey = GlobalKey();

    // ✅ 버튼 활성화 조건: 제목이 trim 후 비어있지 않을 때
    final bool canCreate = _title.trim().isNotEmpty;

    return BasePage(
      appbar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black.withOpacity(0.1),
        title: const Text('새 작업 추가'),
      ),
      child: Column(
        children: [
          //! 내용 (스크롤)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CoolFormField(
                    label: '제목 (필수)',
                    hintText: '무엇을 할 건가요? 예) 주간 보고서 초안 작성',
                    validator: AppValidator.titleMax20, // 20자 초과 경고

                    visualType: CoolFormFieldVisualType.outline,
                    onChanged: (value) {
                      setState(() => _title = value);
                    },
                  ),
                  const Gap(16),
                  CoolFormField(
                    label: '세부 내용 (선택)',
                    hintText: '다음 행동, 참고 링크, 담당자 등을 적어보세요',
                    visualType: CoolFormFieldVisualType.outline,
                    minLines: 4,
                    maxLines: 8,
                    validator: AppValidator.descriptionMax200, // 200자 초과 경고
                    onChanged: (value) {
                      setState(() => _description = value);
                    },
                  ),
                  const Gap(16),

                  //! 우선순위 -> "중요도"로 더 쉬운 용어
                  _buildFrameSection(
                    title: '중요도',
                    child: Container(
                      key: priorityKey,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColor.gray400),
                      ),
                      child: InkWell(
                        onTap: () {
                          showCustomDropdown<String>(
                            context: context,
                            anchorKey: priorityKey,
                            items: Priority.values.map((e) => e.value).toList(),
                            backgroundColor: AppColor.gray200,
                            onItemSelected: (value) {
                              setState(() => _priorityText = value);
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _priorityText ?? '긴급',
                                style: AppTextStyle.med1421.copyWith(
                                  color: AppColor.gray900,
                                ),
                              ),
                              const Icon(Icons.arrow_drop_down,
                                  color: AppColor.gray500),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // //! 진행상태
                  // _buildFrameSection(
                  //   title: '상태',
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: BaseButton(
                  //           onPressed: () {
                  //             setState(() {
                  //               isStatusOnGoing = true;
                  //               AppLog.d('isStatusOnGoing: $isStatusOnGoing');
                  //             });
                  //           },
                  //           child: Container(
                  //             padding: EdgeInsets.symmetric(vertical: 12.h),
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(8),
                  //               color: isStatusOnGoing
                  //                   ? AppColor.primary500
                  //                   : AppColor.gray200,
                  //             ),
                  //             child: Center(
                  //               child: Text(
                  //                 '진행 중',
                  //                 style: TextStyle(
                  //                   color: isStatusOnGoing
                  //                       ? AppColor.white
                  //                       : AppColor.gray700,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Gap(12.w),
                  //       Expanded(
                  //         child: BaseButton(
                  //           onPressed: () {
                  //             setState(() {
                  //               isStatusOnGoing = false;
                  //               AppLog.d('isStatusOnGoing: $isStatusOnGoing');
                  //             });
                  //           },
                  //           child: Container(
                  //             padding: EdgeInsets.symmetric(vertical: 12.h),
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(8),
                  //               color: isStatusOnGoing
                  //                   ? AppColor.gray200
                  //                   : AppColor.primary500,
                  //             ),
                  //             child: Center(
                  //               child: Text(
                  //                 '완료',
                  //                 style: TextStyle(
                  //                   color: isStatusOnGoing
                  //                       ? AppColor.gray700
                  //                       : AppColor.white,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // //! 완료일 (완료일 때에만)
                  // if (!isStatusOnGoing)
                  //   _buildFrameSection(
                  //     title: '완료일',
                  //     child: Container(
                  //       padding: const EdgeInsets.symmetric(horizontal: 16),
                  //       height: 48,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(8),
                  //         border: Border.all(color: AppColor.gray400),
                  //       ),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           const Text('완료일 선택',
                  //               style: TextStyle(color: AppColor.gray900)),
                  //           SvgPicture.asset(AppAsset.calendarIcon),
                  //         ],
                  //       ),
                  //     ),
                  //   ),

                  // //! 마감일
                  // _buildFrameSection(
                  //   title: '마감일 (선택)',
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(horizontal: 16),
                  //     height: 48,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(8),
                  //       border: Border.all(color: AppColor.gray400),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         const Text('마감일을 선택하세요',
                  //             style: TextStyle(color: AppColor.gray900)),
                  //         SvgPicture.asset(AppAsset.calendarIcon),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),

          //! 하단 고정 버튼
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: BaseButton(
                onPressed: canCreate && !isSubmitting // ⬅️ 로딩 중 비활성
                    ? () async {
                        final userId = FirebaseAuth.instance.currentUser?.uid;
                        if (userId == null) {
                          AppLog.e('User not logged in');
                          return;
                        }
                        final request = CreateTodoModel(
                          title: _title,
                          description: _description,
                          priority: _priorityText ?? '긴급',
                          status: isStatusOnGoing
                              ? Status.ongoing.value
                              : Status.completed.value,
                        );

                        // 1) 생성 호출
                        await ref
                            .read(createTodoProvider.notifier)
                            .submit(userId: userId, request: request);
                      }
                    : null,
                child: RoundedContainer(
                  backgroundColor: (canCreate && !isSubmitting)
                      ? AppColor.primary500
                      : AppColor.gray300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isSubmitting ? '저장 중...' : '작업 추가하기',
                        style: AppTextStyle.med1421.copyWith(
                          color: (canCreate && !isSubmitting)
                              ? AppColor.white
                              : AppColor.gray600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
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
          // 🔹 섹션 타이틀 문구도 직관적으로
          Text(
            title,
            style: AppTextStyle.med1421.copyWith(color: AppColor.gray700),
          ),
          const Gap(8),
          child,
        ],
      ),
    );
  }
}
