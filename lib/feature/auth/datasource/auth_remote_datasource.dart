import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDataSource {
  ///
  /// 구글 로그인
  ///
  Future<UserCredential?> signInWithGoogle();

  ///
  /// 로그아웃
  ///
  Future<void> signOut();
}
