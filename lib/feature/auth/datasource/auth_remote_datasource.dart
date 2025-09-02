import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;

abstract interface class AuthRemoteDataSource {
  ///
  /// 구글 로그인
  ///
  Future<fb.UserCredential?> signInWithGoogle();

  ///
  /// 애플 로그인
  ///
  Future<fb.UserCredential?> signInWithApple();

  ///
  /// 카카오 로그인
  ///
  Future<kakao.User?> signInWithKakao();

  ///
  /// 로그아웃
  ///
  Future<void> signOut();
}
