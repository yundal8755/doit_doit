import 'package:doit_doit/app/di/auth_di.dart';
import 'package:doit_doit/app/router/router.dart';
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/app/enum/social_login_platform.dart';
import 'package:doit_doit/feature/auth/entity/auth_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_oauth_provider.g.dart';

@riverpod
class SignInOauth extends _$SignInOauth {
  @override
  Future<AuthEntity?> build() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    return AuthEntity.fromFirebase(user as UserCredential);
  }

  ///
  /// 로그인 기능 구현
  ///
  Future<void> signIn(WidgetRef ref, SocialLoginPlatform platform) async {
    AppLog.d('로그인 시도: $platform');

    final result = await ref.read(signInOauthUsecaseProvider).call(platform);

    result.fold(
      onSuccess: (entity) async {
        state = AsyncValue.data(entity);

        AppLog.d(
            '로그인 성공: ${entity.uid}, ${entity.displayName}, ${entity.email}');

        final isFirstLogin =
            await ref.read(userInfoExistUsecaseProvider).call(entity.uid);

        if (isFirstLogin) {
          AppLog.d('신규 회원 → 회원가입 페이지로 이동');
          if (ref.context.mounted) {
            ref.context.go(AppRoute.signUp.path, extra: platform);
          }
        } else {
          AppLog.d('기존 회원 → 홈으로 이동');
          if (ref.context.mounted) {
            ref.context.go(AppRoute.root.path);
          }
        }
      },
      onFailure: (e) {
        state = AsyncValue.error(e, StackTrace.current);
        AppLog.d('로그인 실패: $e');
      },
    );
  }
}
