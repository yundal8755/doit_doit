import 'package:doit_doit/app/di/auth_di.dart';
import 'package:doit_doit/app/router/router.dart';
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/app/enum/social_login_platform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_oauth_provider.g.dart';

@riverpod
class SignInOauth extends _$SignInOauth {
  @override
  Future<User?> build() async {
    return await ref
        .watch(signInOauthUsecaseProvider)
        .call(SocialLoginPlatform.google);
  }

  ///
  /// 소셜 로그인으로 유저 존재 여부 확인 후 라우팅
  ///
  Future<void> signIn(WidgetRef ref, SocialLoginPlatform platform) async {
    AppLog.d('로그인 시도: $platform');

    final user = await ref.read(signInOauthUsecaseProvider).call(platform);

    if (user != null) {
      AppLog.d(
          '로그인 성공: ${user.uid}\n ${user.displayName}\n ${user.email}\n ${user.photoURL}');

      final bool isFirstLogin =
          await ref.read(userInfoExistUsecaseProvider).call(user.uid);

      if (isFirstLogin) {
        AppLog.d('신규 회원 → 회원가입 페이지로 이동');
        if (ref.context.mounted) ref.context.go(AppRoute.signUp.path);
      } else {
        AppLog.d('기존 회원 → 홈으로 이동');
        if (ref.context.mounted) ref.context.go(AppRoute.root.path);
      }
    } else {
      AppLog.d('로그인 실패');
    }
  }
}
