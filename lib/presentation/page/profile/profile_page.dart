import 'package:cached_network_image/cached_network_image.dart';
import 'package:doit_doit/app/di/auth_di.dart';
import 'package:doit_doit/app/router/router.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:doit_doit/presentation/component/button/base_button.dart';
import 'package:doit_doit/presentation/page/profile/profile_state.dart';
import 'package:doit_doit/presentation/widget/base/base_page.dart';
import 'package:doit_doit/presentation/widget/common/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends ConsumerWidget with ProfileState {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BasePage(
      appbar: AppBar(
        title: const Text('프로필'),
        backgroundColor: Colors.white,
      ),
      child: userAsync(ref).when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('로그인 정보가 없습니다.'));
          }
          return Center(
            child: Column(
              children: [
                Column(
                  children: [
                    const Gap(24),
                    SizedBox(
                      width: 96.w,
                      height: 96.h,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: user.profileImageUrl ?? '',
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const Gap(16),
                    Text(
                      user.nickname ?? '닉네임 없음',
                      style: AppTextStyle.bold2028
                          .copyWith(color: AppColor.gray900),
                    ),
                    const Gap(4),
                    Text(
                      user.email ?? '이메일 없음',
                      style: AppTextStyle.med1421
                          .copyWith(color: AppColor.gray700),
                    )
                  ],
                ),
                const Spacer(),
                BaseButton(
                  child: RoundedContainer(
                    child: Text(
                      '로그아웃',
                      style: AppTextStyle.med1421
                          .copyWith(color: AppColor.error400),
                    ),
                  ),
                  onPressed: () {
                    ref.read(signOutUseCaseProvider).call();
                    context.go(AppRoute.signIn.path);
                  },
                )
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('에러 발생: $error')),
      ),
    );
  }
}
