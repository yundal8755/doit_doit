import 'package:doit_doit/app/enum/priority.dart';
import 'package:doit_doit/app/util/app_log.dart';
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
class UpdateTodoPage extends ConsumerStatefulWidget {
  final TodoModel todoModel;

  const UpdateTodoPage({super.key, required this.todoModel});

  @override
  ConsumerState<UpdateTodoPage> createState() => _UpdateTodoPageState();
}

class _UpdateTodoPageState extends ConsumerState<UpdateTodoPage>
    with TodoEvent {
  late String _title;
  String? _description;
  String? _priorityText;
  late bool isComplete;

  @override
  void initState() {
    super.initState();

    // 전달받은 formState에서 초기값 할당
    _title = widget.todoModel.title;
    _description = widget.todoModel.description;
    _priorityText = widget.todoModel.priority;
    isComplete = widget.todoModel.isComplete;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLog.d(widget.todoModel.toString());

    final createState = ref.watch(createTodoProvider);
    final isSubmitting = createState.isLoading;
    final GlobalKey priorityKey = GlobalKey();
    final bool canCreate = _title.trim().isNotEmpty;

    // 업데이트 상태 리스너
    updateTodoListeners(ref);

    return BasePage(
      appbar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black.withOpacity(0.1),
        title: const Text('할 일 수정'),
      ),
      child: Column(
        children: [
          // 본문 (폼 양식)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CoolFormField(
                    label: '제목 (필수)',
                    hintText: '무엇을 할 건가요? 예) 주간 보고서 초안 작성',
                    initialValue: _title,
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
                    initialValue: _description,
                    visualType: CoolFormFieldVisualType.outline,
                    minLines: 4,
                    maxLines: 8,
                    validator: AppValidator.descriptionMax200, // 200자 초과 경고
                    onChanged: (value) {
                      setState(() => _description = value);
                    },
                  ),
                  const Gap(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(width: 0.5, color: AppColor.gray500),
                        ),
                        child: InkWell(
                          onTap: () {
                            showCustomDropdown<String>(
                              context: context,
                              anchorKey: priorityKey,
                              items:
                                  Priority.values.map((e) => e.value).toList(),
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
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 하단 고정 버튼
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: BaseButton(
                onPressed: canCreate && !isSubmitting
                    ? () {
                        final model = TodoModel(
                            id: widget.todoModel.id,
                            title: _title,
                            description: _description,
                            priority: _priorityText ?? '긴급',
                            isComplete: isComplete);

                        onTapUpdateBtn(ref, model);
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
                        isSubmitting ? '저장 중...' : '수정하기',
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
