import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/feature/auth/datasource/auth_remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final fb.FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl({
    fb.FirebaseAuth? auth,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth ?? fb.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  ///
  /// Google 로그인
  ///
  @override
  Future<fb.UserCredential?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = fb.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return _auth.signInWithCredential(credential);
  }

  ///
  /// Apple 로그인
  ///
  @override
  Future<fb.UserCredential?> signInWithApple() async {
    final appleIdCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final oauthCredential = fb.OAuthProvider('apple.com').credential(
      idToken: appleIdCredential.identityToken,
      accessToken: appleIdCredential.authorizationCode,
    );

    return _auth.signInWithCredential(oauthCredential);
  }

  ///
  /// Kakao 로그인
  ///
  @override
  Future<kakao.User?> signInWithKakao() async {
    try {
      final talkInstalled = await kakao.isKakaoTalkInstalled();
      if (talkInstalled) {
        try {
          final token = await kakao.UserApi.instance.loginWithKakaoTalk();
          AppLog.i('KAKAO TALK LOGIN SUCCESS: ${token.accessToken}');
        } on PlatformException catch (e) {
          AppLog.e('KAKAO TALK LOGIN FAILED(Platform): $e');
          if (e.code == 'CANCELED') return null; // 사용자가 취소
          // 앱 로그인 실패 → 계정 로그인 폴백
          final token = await kakao.UserApi.instance.loginWithKakaoAccount();
          AppLog.i(
              'KAKAO ACCOUNT LOGIN SUCCESS AFTER TALK FAIL: ${token.accessToken}');
        }
      } else {
        final token = await kakao.UserApi.instance.loginWithKakaoAccount();
        AppLog.i('KAKAO ACCOUNT LOGIN SUCCESS (NO TALK): ${token.accessToken}');
      }

      // 토큰 저장은 SDK가 내부 처리. 바로 사용자 정보 조회
      final user = await kakao.UserApi.instance.me();
      AppLog.i('KAKAO USER: id=${user.id}, email=${user.kakaoAccount?.email}');
      return user;
    } catch (e, s) {
      AppLog.e('KAKAO LOGIN TOTAL FAILED: $e\n$s');
      return null;
    }
  }

  ///
  /// 로그아웃
  ///
  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    try {
      await kakao.UserApi.instance.logout();
      AppLog.i('KAKAO LOGOUT SUCCESS');
    } catch (e) {
      AppLog.e('KAKAO LOGOUT FAILED: $e');
    }
  }
}
