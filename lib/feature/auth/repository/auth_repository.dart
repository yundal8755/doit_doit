import 'package:doit_doit/app/enum/social_login_platform.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRepository {
  ///
  /// 소셜 로그인
  ///
  Future<User?> signInOauth(SocialLoginPlatform platform);

  ///
  /// 로그아웃
  ///
  Future<void> signOut();

  ///
  /// 유저가 처음으로 로그인하는건지 Firestore 통해서 확인
  ///
  Future<bool> isFirstLogin(String uid);
}
