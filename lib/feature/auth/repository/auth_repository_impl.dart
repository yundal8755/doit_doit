import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_doit/app/module/error_handling/result.dart';
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/feature/auth/datasource/auth_remote_datasource.dart';
import 'package:doit_doit/app/enum/social_login_platform.dart';
import 'package:doit_doit/feature/auth/entity/auth_entity.dart';
import 'package:doit_doit/feature/auth/repository/auth_repository.dart';

final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._authRemoteDataSource);

  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  Future<Result<AuthEntity>> signInOauth(SocialLoginPlatform platform) async {
    try {
      final credential = switch (platform) {
        SocialLoginPlatform.google =>
          await _authRemoteDataSource.signInWithGoogle(),
        SocialLoginPlatform.kakao =>
          await _authRemoteDataSource.signInWithGoogle(),
        SocialLoginPlatform.apple =>
          await _authRemoteDataSource.signInWithApple(),
        SocialLoginPlatform.naver =>
          await _authRemoteDataSource.signInWithGoogle(),
      };

      if (credential == null || credential.user == null) {
        return Result.failure(Exception("로그인 실패: user가 null"));
      }

      final firebaseUser = credential.user!;

      final entity = AuthEntity(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
        displayName: firebaseUser.displayName,
        providerId: credential.credential?.providerId ?? 'unknown',
        isNewUser: credential.additionalUserInfo?.isNewUser ?? false,
      );

      return Result.success(entity);
    } on Exception catch (e) {
      AppLog.e('에러: $e');
      return Result.failure(e);
    }
  }

  @override
  Future<void> signOut() async {
    await _authRemoteDataSource.signOut();
  }

  @override
  Future<bool> isFirstLogin(String uid) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    // 문서 o -> 첫 로그인이 아니므로 false
    // 문서 x -> 첫 로그인이므로 true
    return !userDoc.exists;
  }
}
