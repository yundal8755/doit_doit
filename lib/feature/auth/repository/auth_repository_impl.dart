import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_doit/feature/auth/datasource/auth_remote_datasource.dart';
import 'package:doit_doit/feature/auth/entity/user_entity.dart';
import 'package:doit_doit/feature/auth/repository/auth_repository.dart';

///
/// 외부 데이터 소스와 직접 소통하는 계층
///
final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._authRemoteDataSource);

  final AuthRemoteDataSource _authRemoteDataSource;

  ///
  /// 구글 로그인
  ///
  @override
  Future<UserEntity?> signInWithGoogle() async {
    final dto = await _authRemoteDataSource.signInWithGoogle();
    return UserEntity(
        userId: dto?.id,
        email: dto?.email,
        nickname: dto?.nickname,
        profileImageUrl: dto?.profileImageUrl);
  }

  ///
  /// 로그아웃
  ///
  @override
  Future<void> signOut() async {
    await _authRemoteDataSource.signOut();
  }

  ///
  /// 프로필 정보 가져오기
  ///
  @override
  Future<UserEntity?> getCurrentUserInfo() async {
    final dto = await _authRemoteDataSource.signInWithGoogle();

    return UserEntity(
        userId: dto?.id,
        email: dto?.email,
        nickname: dto?.nickname,
        profileImageUrl: dto?.profileImageUrl);
  }

  @override
  Future<bool> isUserExist(String uid) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    return userDoc.exists; // 문서가 있으면 true, 없으면 false
  }
}
