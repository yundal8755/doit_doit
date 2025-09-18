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
      switch (platform) {
        case SocialLoginPlatform.google:
          final googleCred = await _authRemoteDataSource.signInWithGoogle();
          return Result.success(AuthEntity.fromFirebase(googleCred!));
        case SocialLoginPlatform.apple:
          final appleCred = await _authRemoteDataSource.signInWithApple();
          return Result.success(AuthEntity.fromFirebase(appleCred!));
        // case SocialLoginPlatform.kakao:
        //   final kakaoUser = await _authRemoteDataSource.signInWithKakao();
        //   return Result.success(AuthEntity.fromKakao(kakaoUser!));
        // case SocialLoginPlatform.naver:
        //   return Result.failure(Exception("네이버 로그인은 아직 지원되지 않습니다."));
      }
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

    return !userDoc.exists;
  }

  /// FirebaseAuth 현재 계정 삭제(재인증 포함)
  @override
  Future<void> deleteUser() => _authRemoteDataSource.deleteCurrentUser();
}
