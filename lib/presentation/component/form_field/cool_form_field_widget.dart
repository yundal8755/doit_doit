import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:doit_doit/presentation/component/form_field/cool_form_field_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

enum CoolFormFieldVisualType {
  underline,
  outline,
}

enum CoolFormFieldStatus {
  inactive, // 포커스X, 입력값X
  active, // 포커스O, 입력값X
  typing, // 입력값 존재
}

class CoolFormField extends FormField<String> {
  final TextEditingController? controller;
  final FocusNode? focusNode;

  // 기능 관련
  final bool isNumber;
  final bool isObscure;
  final bool isSend;
  final bool isSendButtonEnabled;
  final VoidCallback? onSend;

  // 박스 데코(컨테이너용)
  final BoxDecoration? boxDecoration;

  // 별도 라벨/힌트 텍스트
  final String? label; // 라벨
  final String hintText;
  final bool isReadOnly;
  final int? maxLength;
  final bool autofocus;
  final List<TextInputFormatter>? customInputFormatters;
  final TextInputType? customKeyboardType;
  final bool obscureTextInitially;
  final CoolFormFieldVisualType visualType; // 추가

  CoolFormField({
    super.key,
    String? initialValue,
    super.validator,
    super.onSaved,
    AutovalidateMode super.autovalidateMode =
        AutovalidateMode.onUserInteraction,

    // 커스텀 속성
    this.controller,
    this.focusNode,
    this.isNumber = false,
    this.isObscure = false,
    this.isSend = false,
    this.isSendButtonEnabled = false,
    this.onSend,
    this.boxDecoration,

    // 라벨, 힌트, 등등
    required this.label,
    required this.hintText,
    this.isReadOnly = false,
    this.maxLength,
    this.autofocus = false,
    this.customInputFormatters,
    this.customKeyboardType,
    this.obscureTextInitially = false,
    required this.visualType,
  }) : super(
          initialValue:
              controller != null ? controller.text : (initialValue ?? ''),
          builder: (FormFieldState<String> field) {
            final _CoolFormFieldState state = field as _CoolFormFieldState;

            // (A) suffix 위젯 (비밀번호 토글, 메시지 전송, X버튼)
            Widget? suffixWidget;
            if (state.widget.isObscure) {
              suffixWidget = CupertinoButton(
                minSize: 0,
                padding: EdgeInsets.zero,
                onPressed: state.toggleObscure,
                child: Icon(
                  state._obscureText ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                ),
              );
            } else if (state.widget.isSend) {
              suffixWidget = CupertinoButton(
                minSize: 0,
                padding: const EdgeInsets.only(right: 8),
                onPressed: state.widget.isSendButtonEnabled
                    ? state.widget.onSend
                    : null,
                child: const Text('전송'),
              );
            } else if (state.status == CoolFormFieldStatus.typing) {
              suffixWidget = CupertinoButton(
                minSize: 0,
                padding: EdgeInsets.zero,
                onPressed: state.clearText,
                child: const Icon(Icons.clear, size: 20),
              );
            }

            // (B) 포커스 여부
            final bool isFocused = state._effectiveFocusNode.hasFocus;

            // (C) 에러 메시지(validator) 존재하면 errorText
            final String? errorText = field.errorText;

            // 여기서 "어떤 스타일(underline/outline)을 쓸지" 결정
            final InputDecoration effectiveDecoration;
            if (visualType == CoolFormFieldVisualType.outline) {
              effectiveDecoration = CoolFormFieldStyle.getOutlineDecoration(
                isFocused: isFocused,
                hintText: state.widget.hintText.isNotEmpty
                    ? state.widget.hintText
                    : null,
                suffixIcon: suffixWidget,
              );
            } else {
              // 기본 underline
              effectiveDecoration = CoolFormFieldStyle.getUnderlineDecoration(
                isFocused: isFocused,
                hintText: state.widget.hintText.isNotEmpty
                    ? state.widget.hintText
                    : null,
                suffixIcon: suffixWidget,
              );
            }

            // (E) 커서 색상도 포커스 여부에 따라 다름
            const cursorColor = CoolFormFieldStyle.activeColor;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // (1) 별도의 라벨 영역
                if (state.widget.label != null) ...[
                  // 라벨 아래에 2px 정도 패딩
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      state.widget.label!,
                      style: AppTextStyle.med1421.copyWith(
                          color: isFocused
                              ? CoolFormFieldStyle.activeColor
                              : AppColor.gray500),
                    ),
                  ),
                ],

                Container(
                  decoration: state.widget.boxDecoration,
                  child: TextField(
                    controller: state._effectiveController,
                    focusNode: state._effectiveFocusNode,
                    keyboardType: state.effectiveKeyboardType,
                    inputFormatters: state.effectiveInputFormatters,
                    maxLength: state.widget.maxLength,
                    readOnly: state.widget.isReadOnly,
                    obscureText: state._obscureText,
                    autofocus: state.widget.autofocus,
                    cursorColor: cursorColor,
                    decoration: effectiveDecoration,
                    onChanged: (value) {
                      field.didChange(value);
                      state.onTextChanged(value);
                    },
                  ),
                ),

                // (F) 에러 메시지 (커스텀 표시, 만약 InputDecoration의 기본 에러 문구를 쓰고 싶다면 생략 가능)
                if (errorText != null) ...[
                  const Gap(6),
                  Row(
                    children: [
                      const Icon(Icons.error_outline,
                          size: 16, color: AppColor.error500),
                      const SizedBox(width: 6),
                      Text(
                        errorText,
                        style: AppTextStyle.med1421
                            .copyWith(color: AppColor.error500),
                      ),
                    ],
                  ),
                ],
              ],
            );
          },
        );

  @override
  FormFieldState<String> createState() => _CoolFormFieldState();
}

class _CoolFormFieldState extends FormFieldState<String> {
  TextEditingController? _controller;
  FocusNode? _focusNode;
  bool _obscureText = false; // 비밀번호 보기/숨기기

  CoolFormFieldStatus _status = CoolFormFieldStatus.inactive;

  @override
  CoolFormField get widget => super.widget as CoolFormField;
  CoolFormFieldStatus get status => _status;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller!;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode!;

  TextInputType get defaultNumberKeyboard => TextInputType.number;
  List<TextInputFormatter> get defaultNumberFormatter =>
      [FilteringTextInputFormatter.digitsOnly];

  TextInputType get effectiveKeyboardType {
    if (widget.customKeyboardType != null) {
      return widget.customKeyboardType!;
    } else if (widget.isNumber) {
      return defaultNumberKeyboard;
    } else {
      return TextInputType.text;
    }
  }

  List<TextInputFormatter>? get effectiveInputFormatters {
    if (widget.customInputFormatters != null &&
        widget.customInputFormatters!.isNotEmpty) {
      return widget.customInputFormatters;
    } else if (widget.isNumber) {
      return defaultNumberFormatter;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    // 컨트롤러
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller!.text = widget.initialValue ?? '';
    }

    // 포커스노드
    if (widget.focusNode == null) {
      _focusNode = FocusNode();
    }

    // 비밀번호 모드 초기값
    _obscureText = widget.obscureTextInitially;

    // 포커스 상태 감지
    _effectiveFocusNode.addListener(_handleFocusChange);

    // 초기 상태
    _updateStatus(_effectiveController.text, _effectiveFocusNode.hasFocus);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller?.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode?.dispose();
    }
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void didUpdateWidget(covariant CoolFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // initialValue가 변경됐으면 반영
    if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != value) {
      setValue(widget.initialValue);
      if (_effectiveController.text != widget.initialValue) {
        _effectiveController.text = widget.initialValue ?? '';
      }
    }
  }

  // 포커스 상태 변화를 감지
  void _handleFocusChange() {
    _updateStatus(_effectiveController.text, _effectiveFocusNode.hasFocus);
  }

  void onTextChanged(String value) {
    didChange(value);
    _updateStatus(value, _effectiveFocusNode.hasFocus);
  }

  void _updateStatus(String text, bool hasFocus) {
    if (text.isEmpty) {
      _status =
          hasFocus ? CoolFormFieldStatus.active : CoolFormFieldStatus.inactive;
    } else {
      _status = CoolFormFieldStatus.typing;
    }
    setState(() {});
  }

  void toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void clearText() {
    _effectiveController.clear();
    didChange('');
    _updateStatus('', _effectiveFocusNode.hasFocus);
  }
}
