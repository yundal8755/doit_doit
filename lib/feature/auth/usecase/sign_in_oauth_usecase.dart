import 'package:doit_doit/app/enum/social_login_platform.dart';
import 'package:doit_doit/feature/auth/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

///
/// 소셜 로그인 기능 구현
///
class SignInOauthUsecase {
  const SignInOauthUsecase(this._authRepository);

  final AuthRepository _authRepository;

  Future<User?> call(SocialLoginPlatform platform) async {
    return _authRepository.signInOauth(platform);
  }
}
