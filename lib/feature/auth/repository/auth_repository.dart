import 'package:doit_doit/app/enum/social_login_platform.dart';
import 'package:doit_doit/app/module/error_handling/result.dart';
import 'package:doit_doit/feature/auth/entity/auth_entity.dart';

abstract interface class AuthRepository {
  ///
  /// 소셜 로그인
  ///
  Future<Result<AuthEntity>> signInOauth(SocialLoginPlatform platform);

  ///
  /// 로그아웃
  ///
  Future<void> signOut();

  ///
  /// 유저가 처음으로 로그인하는건지 Firestore 통해서 확인
  ///
  Future<bool> isFirstLogin(String uid);
}
