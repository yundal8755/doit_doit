import 'dart:io';

import 'package:doit_doit/app/style/app_asset.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:doit_doit/app/enum/social_login_platform.dart';
import 'package:doit_doit/presentation/component/button/base_button.dart';
import 'package:doit_doit/presentation/page/auth/sign_in_event.dart';
import 'package:doit_doit/presentation/provider/auth/sign_in_oauth_provider.dart';
import 'package:doit_doit/presentation/widget/base/base_page.dart';
import 'package:doit_doit/presentation/widget/common/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SignInPage extends ConsumerWidget with SignInEvent {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(signInOauthProvider.notifier);

    return BasePage(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAsset.logo),
            const Gap(8),
            Text(
              '프로젝트와 할 일을 스마트하게 관리하세요',
              style: AppTextStyle.med1421.copyWith(color: AppColor.gray700),
            ),
            const Gap(48),
            Column(
              children: [
                // TODO : 카카오 로그인 - 안드로이드도 구현되는지 확인하기
                // TODO : Firestore DTO 대신 카카오, 네이버까지 통합된 커스텀 DTO로 회원가입/로그인 처리하기
                _buildSocialButton(
                  text: '카카오로 계속하기',
                  backgroundColor: AppColor.kakao,
                  textColor: AppColor.black,
                  onPressed: () =>
                      notifier.signIn(ref, SocialLoginPlatform.kakao),
                  icon: SvgPicture.asset(AppAsset.kakao),
                ),
                const Gap(16),
                _buildSocialButton(
                  text: '네이버로 계속하기',
                  backgroundColor: AppColor.naver,
                  textColor: AppColor.white,
                  onPressed: () => onClickedNaverSignInButton(ref: ref),
                  icon: SvgPicture.asset(AppAsset.naver),
                ),
                const Gap(16),
                _buildSocialButton(
                  borderColor: AppColor.gray300,
                  text: 'Google로 계속하기',
                  backgroundColor: AppColor.white,
                  textColor: AppColor.black,
                  onPressed: () =>
                      notifier.signIn(ref, SocialLoginPlatform.google),
                  icon: SvgPicture.asset(AppAsset.google),
                ),
                const Gap(16),
                if (Platform.isIOS)
                  _buildSocialButton(
                    text: 'Apple로 계속하기',
                    backgroundColor: AppColor.black,
                    textColor: AppColor.white,
                    onPressed: () =>
                        notifier.signIn(ref, SocialLoginPlatform.apple),
                    icon: SvgPicture.asset(AppAsset.apple),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// 소셜 로그인 버튼 위젯
  Widget _buildSocialButton({
    Color? borderColor,
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
    required Widget icon,
  }) {
    return BaseButton(
      onPressed: onPressed,
      child: RoundedContainer(
        borderColor: borderColor,
        backgroundColor: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const Gap(12),
            Text(
              text,
              style: AppTextStyle.med1421.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
