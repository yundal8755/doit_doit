import 'package:doit_doit/app/enum/social_login_platform.dart';
import 'package:doit_doit/app/router/router.dart';
import 'package:doit_doit/app/style/app_asset.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/feature/user/dto/user_dto.dart';
import 'package:doit_doit/presentation/component/button/base_button.dart';
import 'package:doit_doit/presentation/component/form_field/cool_form_field_widget.dart';
import 'package:doit_doit/presentation/provider/auth/sign_in_oauth_provider.dart';
import 'package:doit_doit/presentation/provider/user/user_provider.dart';
import 'package:doit_doit/presentation/widget/base/base_page.dart';
import 'package:doit_doit/presentation/widget/common/rounded_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  bool isButtonEnabled = false;

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
                      isButtonEnabled = value.trim().length >= 2;
                    });
                  },
                ),
              ],
            ),
            const Spacer(),
            BaseButton(
              onPressed: isButtonEnabled
                  ? () async {
                      // TODO: 임시 dto
                      // TODO: event mixin 만들어서 넘겨주기
                      final currentUser = FirebaseAuth.instance.currentUser;

                      final dto = UserDto(
                          nickname: '윤수',
                          signUpPlatform: SocialLoginPlatform.google,
                          platformUuid: currentUser?.uid ?? '');
                      final provider = ref.read(userProvider.notifier);
                      try {
                        await provider.createUser(ref, dto);
                        // TODO: 임시 로직
                        final entity = await provider.fetchUser(ref, '12345');

                        if (entity?.nickname != null &&
                            entity?.userId != null) {
                          context.go(AppRoute.root.path);
                        } else {
                          AppLog.d('닉네임 혹은 userId가 null입니다');
                        }
                      } catch (e) {
                        AppLog.e(e);
                      }
                      // ✅ 회원가입 로직 실행
                      print("회원가입 실행");
                    }
                  : null, // null이면 자동으로 비활성화
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
