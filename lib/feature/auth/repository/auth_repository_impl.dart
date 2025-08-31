import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_doit/feature/auth/datasource/auth_remote_datasource.dart';
import 'package:doit_doit/app/enum/social_login_platform.dart';
import 'package:doit_doit/feature/auth/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._authRemoteDataSource);

  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  Future<User?> signInOauth(SocialLoginPlatform platform) {
    switch (platform) {
      case SocialLoginPlatform.google:
      case SocialLoginPlatform.apple:
      case SocialLoginPlatform.kakao:
      case SocialLoginPlatform.naver:
        return _authRemoteDataSource.signInWithGoogle();
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


///
/// TODO : UserRepositoryImpl로 옮길 예정
///
  // @override
  // Future<UserEntity?> signInWithGoogle() async {
  //   final dto = await _authRemoteDataSource.signInWithGoogle();
  //   return UserEntity(
  //       userId: dto?.id,
  //       email: dto?.email,
  //       nickname: dto?.nickname,
  //       profileImageUrl: dto?.profileImageUrl);
  // }

    // @override
  // Future<UserEntity?> getCurrentUserInfo() async {
  //   final dto = await _authRemoteDataSource.signInWithGoogle();

  //   return UserEntity(
  //       userId: dto?.id,
  //       email: dto?.email,
  //       nickname: dto?.nickname,
  //       profileImageUrl: dto?.profileImageUrl);
  // }