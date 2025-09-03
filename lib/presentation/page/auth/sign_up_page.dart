import 'package:doit_doit/app/enum/social_login_platform.dart';
import 'package:doit_doit/app/style/app_asset.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:doit_doit/presentation/component/button/base_button.dart';
import 'package:doit_doit/presentation/component/form_field/cool_form_field_widget.dart';
import 'package:doit_doit/presentation/page/auth/sign_up_event.dart';
import 'package:doit_doit/presentation/widget/base/base_page.dart';
import 'package:doit_doit/presentation/widget/common/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SignUpPage extends ConsumerStatefulWidget {
  final SocialLoginPlatform platform;

  const SignUpPage({super.key, required this.platform});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> with SignUpEvent {
  bool isButtonEnabled = false;
  String nickname = '';

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Gap(36),
            Column(
              children: [
                SvgPicture.asset(AppAsset.logo),
                const Gap(8),
                Text(
                  '회원가입 페이지입니다.',
                  style: AppTextStyle.med1421.copyWith(color: AppColor.gray700),
                ),
                const Gap(32),
                CoolFormField(
                  label: '닉네임',
                  hintText: '닉네임을 입력해주세요',
                  visualType: CoolFormFieldVisualType.outline,
                  onChanged: (value) {
                    setState(() {
                      nickname = value;
                      isButtonEnabled = value.trim().length >= 2;
                    });
                  },
                ),
              ],
            ),
            const Spacer(),
            BaseButton(
              onPressed: isButtonEnabled
                  ? () => onClickedSignUpButton(
                        ref: ref,
                        platform: widget.platform,
                        nickanme: nickname,
                      )
                  : null,
              child: RoundedContainer(
                backgroundColor:
                    isButtonEnabled ? AppColor.primary500 : AppColor.gray300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '회원가입하기',
                      style: AppTextStyle.med1421.copyWith(
                        color:
                            isButtonEnabled ? AppColor.white : AppColor.gray500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}
