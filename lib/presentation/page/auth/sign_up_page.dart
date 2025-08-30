import 'package:doit_doit/app/style/app_asset.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:doit_doit/presentation/component/button/base_button.dart';
import 'package:doit_doit/presentation/component/form_field/cool_form_field_widget.dart';
import 'package:doit_doit/presentation/provider/user/user_info_provider.dart';
import 'package:doit_doit/presentation/widget/base/base_page.dart';
import 'package:doit_doit/presentation/widget/common/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.read(userInfoProvider);

    return BasePage(
      child: Center(
          child: userAsync.when(
        data: (user) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAsset.logo),
              const Gap(8),
              Text(
                '회원가입 페이지입니다.',
                style: AppTextStyle.med1421.copyWith(color: AppColor.gray700),
              ),
              const Gap(96),
              Column(
                children: [
                  const Gap(16),
                  CoolFormField(
                      label: '닉네임',
                      hintText: '${user?.nickname}',
                      visualType: CoolFormFieldVisualType.outline),
                  BaseButton(
                    onPressed: () {},
                    child: RoundedContainer(
                      backgroundColor: AppColor.primary500,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '회원가입하기',
                            style: AppTextStyle.med1421
                                .copyWith(color: AppColor.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
        error: (error, stackTrace) => const CircularProgressIndicator(),
        loading: () => const CircularProgressIndicator(),
      )),
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
