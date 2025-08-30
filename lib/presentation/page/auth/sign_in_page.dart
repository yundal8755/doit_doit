import 'package:doit_doit/app/router/router.dart';
import 'package:doit_doit/app/style/app_asset.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/app/di/auth_di.dart';
import 'package:doit_doit/presentation/component/button/base_button.dart';
import 'package:doit_doit/presentation/widget/base/base_page.dart';
import 'package:doit_doit/presentation/widget/common/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usecase = ref.read(signInWithGoogleUseCaseProvider);

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
                _buildSocialButton(
                  text: '카카오로 계속하기',
                  backgroundColor: AppColor.kakao,
                  textColor: AppColor.black,
                  onPressed: () {
                    AppLog.d('카카오 로그인 클릭');
                    context.go(AppRoute.root.path);
                  },
                  icon: SvgPicture.asset(AppAsset.kakao),
                ),
                const Gap(16),
                _buildSocialButton(
                  text: '네이버로 계속하기',
                  backgroundColor: AppColor.naver,
                  textColor: AppColor.white,
                  onPressed: () {
                    AppLog.d('네이버 로그인 클릭');
                    context.go(AppRoute.root.path);
                  },
                  icon: SvgPicture.asset(AppAsset.naver),
                ),
                const Gap(16),
                _buildSocialButton(
                  borderColor: AppColor.gray300,
                  text: 'Google로 계속하기',
                  backgroundColor: AppColor.white,
                  textColor: AppColor.black,
                  onPressed: () async {
                    AppLog.d('google 로그인 클릭');

                    final user = await usecase();
                    AppLog.d('user: $user');

                    if (user != null) {
                      AppLog.d('로그인 성공');
                      if (context.mounted) {
                        final isUserExist = await ref
                            .read(userInfoExistUsecaseProvider)
                            .call(user.userId);

                        if (isUserExist) {
                          context.go(AppRoute.root.path);
                        }
                        context.go(AppRoute.signUp.path);

                        AppLog.d('유저 정보가 없습니다');
                      }
                    } else {
                      AppLog.d('로그인 실패');
                    }
                  },
                  icon: SvgPicture.asset(AppAsset.google),
                ),
                const Gap(16),
                _buildSocialButton(
                  text: 'Apple로 계속하기',
                  backgroundColor: AppColor.black,
                  textColor: AppColor.white,
                  onPressed: () {
                    AppLog.d('apple 로그인 클릭');
                    context.go(AppRoute.root.path);
                  },
                  icon: SvgPicture.asset(AppAsset.apple),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

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
