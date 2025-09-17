import 'package:doit_doit/app/enum/priority.dart';
import 'package:doit_doit/app/util/app_validator.dart';
import 'package:doit_doit/feature/todo/model/todo_model.dart';
import 'package:doit_doit/presentation/widget/component/button/base_button.dart';
import 'package:doit_doit/presentation/widget/component/drop_down/cool_drop_down.dart';
import 'package:doit_doit/presentation/widget/component/form_field/cool_form_field_widget.dart';
import 'package:doit_doit/presentation/page/home/todo_event.dart';
import 'package:doit_doit/presentation/provider/todo/create_todo_provider.dart';
import 'package:doit_doit/presentation/widget/base/base_page.dart';
import 'package:doit_doit/presentation/widget/common/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:gap/gap.dart';

///
/// 새 할 일 생성 페이지
///
class CreateTodoPage extends ConsumerStatefulWidget {
  const CreateTodoPage({super.key});

  @override
  ConsumerState<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends ConsumerState<CreateTodoPage>
    with TodoEvent {
  String _title = '';
  String? _description;
  String? _priorityText;
  bool isComplete = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final createState = ref.watch(createTodoProvider);
    final isSubmitting = createState.isLoading;
    final GlobalKey priorityKey = GlobalKey();
    final bool canCreate = _title.trim().isNotEmpty;

    // 새 할 일 생성 상태 리스너
    initCreateTodoListeners(ref);

    return BasePage(
      appbar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black.withOpacity(0.06),
        title: const Text('할 일 추가'),
      ),
      child: Column(
        children: [
          // 본문 (폼 양식)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 그룹 박스: 제목
                  CoolFormField(
                    label: '제목',
                    hintText: '예: 물마시기',
                    validator: AppValidator.titleMax20, // 20자 초과 경고
                    visualType: CoolFormFieldVisualType.outline,
                    onChanged: (value) {
                      setState(() => _title = value);
                    },
                    minLines: 1,
                    maxLines: 2,
                  ),

                  const Gap(12),

                  // 그룹 박스: 세부 내용
                  CoolFormField(
                    label: '세부 내용 (선택)',
                    hintText: '필요한 내용을 간단히 메모하세요',
                    visualType: CoolFormFieldVisualType.outline,
                    minLines: 4,
                    maxLines: 8,
                    validator: AppValidator.descriptionMax200,
                    onChanged: (value) {
                      setState(() => _description = value);
                    },
                  ),

                  const Gap(12),

                  // 우선순위: 심플하고 깔끔한 선택박스
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '우선순위',
                      style: AppTextStyle.med1421
                          .copyWith(color: AppColor.gray500),
                    ),
                  ),
                  Container(
                    key: priorityKey,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColor.gray200),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
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
                                color: AppColor.gray400),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Gap(8),

                  // 가이드 텍스트
                  Text(
                    '필요 시 우선순위를 설정하세요. 기본값은 긴급입니다.',
                    style:
                        AppTextStyle.med1216.copyWith(color: AppColor.gray400),
                  ),
                ],
              ),
            ),
          ),

          // 하단 고정 버튼 (간결하고 명확)
          SafeArea(
            top: false,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: BaseButton(
                onPressed: canCreate && !isSubmitting
                    ? () {
                        final model = TodoModel(
                          title: _title.trim(),
                          description: _description?.trim(),
                          priority: _priorityText ?? '보통',
                          isComplete: isComplete,
                        );

                        onTapCreateBtn(ref, model);
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
                        isSubmitting ? '저장 중...' : '저장',
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
}
