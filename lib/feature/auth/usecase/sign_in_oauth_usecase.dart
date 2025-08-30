import 'package:doit_doit/feature/auth/enum/social_login_platform.dart';
import 'package:doit_doit/feature/auth/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInOauthUsecase {
  const SignInOauthUsecase(this._authRepository);

  final AuthRepository _authRepository;

  Future<User?> call(SocialLoginPlatform platform) async {
    return _authRepository.signInOauth(platform);
  }
}
