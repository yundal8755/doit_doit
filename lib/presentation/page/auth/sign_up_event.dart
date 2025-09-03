import 'package:doit_doit/app/enum/social_login_platform.dart';
import 'package:doit_doit/app/router/router.dart';
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/feature/user/dto/user_dto.dart';
import 'package:doit_doit/presentation/provider/user/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

mixin SignUpEvent {
  ///
  /// 로그인 버튼 클릭시
  ///
  Future<void> onClickedSignUpButton({
    required WidgetRef ref,
    required SocialLoginPlatform platform,
    required String nickanme,
  }) async {
    AppLog.d('회원가입 실행');
    final currentUser = FirebaseAuth.instance.currentUser;
    final dto = UserDto(
      nickname: nickanme,
      signUpPlatform: platform,
      platformUuid: currentUser?.uid ?? '',
    );

    final provider = ref.read(userProvider.notifier);
    try {
      await provider.createUser(ref, dto);
      await provider.fetchUser(ref, currentUser?.uid ?? '');

      ref.context.go(AppRoute.root.path);
    } catch (e) {
      AppLog.e(e);
    }
  }
}
