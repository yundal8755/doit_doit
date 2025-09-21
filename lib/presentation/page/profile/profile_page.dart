import 'package:doit_doit/app/di/auth_di.dart';
import 'package:doit_doit/app/router/router.dart';
import 'package:doit_doit/app/style/app_asset.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:doit_doit/presentation/provider/user/delete_account_provider.dart';
import 'package:doit_doit/presentation/widget/component/alert_dialog/cool_alert_dialog.dart';
import 'package:doit_doit/presentation/widget/component/button/base_button.dart';
import 'package:doit_doit/presentation/provider/user/user_provider.dart';
import 'package:doit_doit/presentation/widget/base/base_page.dart';
import 'package:doit_doit/presentation/widget/common/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);

    return BasePage(
      appbar: AppBar(
        title: const Text('프로필'),
        backgroundColor: Colors.white,
      ),
      child: userAsync.when(
        data: (user) {
          final nickname = user?.nickname ?? '닉네임 없음';
          final email = user?.email ?? '이메일 없음';
          const joinDate = '가입일: 2024.01.15'; // TODO : 실제 데이터 연결

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 상단: 프로필 카드
              RoundedContainer(
                borderColor: AppColor.gray200,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 텍스트 블록
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nickname,
                          style: AppTextStyle.semi1828
                              .copyWith(color: AppColor.gray900),
                        ),
                        Gap(4.h),
                        Text(
                          joinDate,
                          style: AppTextStyle.med1216
                              .copyWith(color: AppColor.gray700),
                        ),
                        Gap(8.h),
                        Text(
                          email,
                          style: AppTextStyle.med1421
                              .copyWith(color: AppColor.gray600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Gap(24.h),

              // 타일 리스트
              _buildTile(
                assetName: AppAsset.privacyPolicyIcon,
                title: '개인정보 처리방침',
                onTap: () async {
                  final uri = Uri.parse(
                      'https://showy-repair-fd3.notion.site/275df3b9d92180f9903ffac1481bd383');
                  if (!await launchUrl(uri,
                      mode: LaunchMode.externalApplication)) {
                    // 실패 시 간단한 SnackBar로 알림
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('페이지를 열 수 없습니다')),
                    );
                  }
                },
              ),
              // _buildTile(
              //   assetName: AppAsset.termsOfServiceIcon,
              //   title: '서비스 이용약관',
              //   onTap: () {},
              // ),

              const Spacer(),

              // 로그아웃, 회원탈퇴
              SafeArea(
                bottom: true,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 로그아웃
                      BaseButton(
                        onPressed: () => showLogoutDialog(context, ref),
                        child: RoundedContainer(
                          radius: 1000,
                          backgroundColor: AppColor.gray300,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          child: Center(
                            child: Text(
                              '로그아웃',
                              style: AppTextStyle.med1421
                                  .copyWith(color: AppColor.gray700),
                            ),
                          ),
                        ),
                      ),

                      const Gap(12),

                      // 회원탈퇴
                      BaseButton(
                        onPressed: () => showWithdrawDialog(context, ref),
                        child: RoundedContainer(
                          radius: 1000,
                          backgroundColor: AppColor.gray050,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          child: Center(
                            child: Text(
                              '회원탈퇴',
                              style: AppTextStyle.med1421
                                  .copyWith(color: AppColor.error400),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const Center(child: Text('에러가 발생했습니다')),
      ),
    );
  }

  /// 타일 위젯 빌더
  Widget _buildTile({
    required String title,
    required VoidCallback onTap,
    required String assetName,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: BaseButton(
        onPressed: onTap,
        child: RoundedContainer(
          borderColor: AppColor.gray200,
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(assetName, width: 20.w, height: 20.w),
                  const Gap(12),
                  Text(
                    title,
                    style:
                        AppTextStyle.med1421.copyWith(color: AppColor.gray800),
                  )
                ],
              ),
              SvgPicture.asset(AppAsset.chevronRightIcon)
            ],
          ),
        ),
      ),
    );
  }

  /// 회원탈퇴 다이얼로그
  void showWithdrawDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => CoolAlertDialog.dividedBtn(
        title: "회원탈퇴",
        subTitle: "정말로 탈퇴하시겠습니까?\n탈퇴 시 모든 데이터가 삭제됩니다.",
        leftBtnContent: "취소",
        rightBtnContent: "탈퇴하기",
        onLeftBtnClicked: () => context.pop(),
        onRightBtnClicked: () async {
          final result =
              await ref.read(deleteAccountProvider.notifier).delete();

          result.fold(
            onSuccess: (_) {
              // close dialog then navigate to sign-in
              context.pop();
              context.go(AppRoute.signIn.path);
            },
            onFailure: (e) {
              // keep dialog open and show error alert
              showDialog(
                context: context,
                builder: (_) => CoolAlertDialog.singleBtn(
                  title: "탈퇴 실패",
                  subTitle: '탈퇴 중 오류가 발생했습니다\n잠시 후 다시 시도해주세요.',
                  btnContent: "확인",
                  onBtnClicked: () => context.pop(),
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// 로그아웃 다이얼로그
  void showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => CoolAlertDialog.dividedBtn(
        title: "로그아웃",
        subTitle: "정말로 로그아웃하시겠습니까?",
        leftBtnContent: "취소",
        rightBtnContent: "확인",
        onLeftBtnClicked: () => context.pop(),
        onRightBtnClicked: () {
          ref.read(signOutUseCaseProvider).call();
          context.go(AppRoute.signIn.path);
        },
      ),
    );
  }
}
