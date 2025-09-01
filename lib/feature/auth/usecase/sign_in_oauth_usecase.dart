import 'package:doit_doit/app/enum/social_login_platform.dart';
import 'package:doit_doit/app/module/error_handling/result.dart';
import 'package:doit_doit/feature/auth/entity/auth_entity.dart';
import 'package:doit_doit/feature/auth/repository/auth_repository.dart';

///
/// 소셜 로그인 기능 구현
///
class SignInOauthUsecase {
  const SignInOauthUsecase(this._authRepository);

  final AuthRepository _authRepository;

  Future<Result<AuthEntity>> call(SocialLoginPlatform platform) async {
    return _authRepository.signInOauth(platform);
  }
}
