import 'package:doit_doit/feature/auth/datasource/dto/user_dto.dart';

abstract interface class AuthRemoteDataSource {
  ///
  /// 구글 로그인
  ///
  Future<UserDto?> signInWithGoogle();

  ///
  /// 로그아웃
  ///
  Future<void> signOut();
}
