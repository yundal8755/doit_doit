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
    await _auth.signOut();
    try {
      AppLog.i('로그아웃 되었습니디ㅏ');
    } catch (e) {
      AppLog.e('로그아웃에 문제가 있습니다: $e');
    }
  }

  ///
  /// 최근 로그인 필요 에러(requires-recent-login) 처리 포함
  ///
  @override
  Future<void> deleteCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw fb.FirebaseAuthException(
          code: 'no-current-user', message: '로그인이 필요합니다.');
    }

    Future<void> reauth() async {
      final providerIds = user.providerData.map((p) => p.providerId).toList();
      AppLog.i('providerIds: $providerIds');

      if (providerIds.contains('google.com')) {
        var googleUser = await _googleSignIn.signInSilently();
        googleUser ??= await _googleSignIn.signIn();
        if (googleUser == null) {
          throw fb.FirebaseAuthException(
              code: 'reauth-canceled', message: '재인증 취소');
        }
        final token = await googleUser.authentication;
        final cred = fb.GoogleAuthProvider.credential(
          accessToken: token.accessToken,
          idToken: token.idToken,
        );
        await user.reauthenticateWithCredential(cred);
        return;
      }

      if (providerIds.contains('apple.com')) {
        try {
          final apple = await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName
            ],
          );
          final cred = fb.OAuthProvider('apple.com').credential(
            idToken: apple.identityToken,
            accessToken: apple.authorizationCode,
          );
          await user.reauthenticateWithCredential(cred);
          return;
        } on PlatformException catch (e) {
          if (e.code == 'CANCELED') {
            throw fb.FirebaseAuthException(
                code: 'reauth-canceled', message: '재인증 취소');
          }
          rethrow;
        }
      }

      // 그 외 공급자는 앱 정책에 맞게 분기
      throw fb.FirebaseAuthException(
        code: 'unsupported-provider',
        message: '지원되지 않는 로그인 방식입니다. 다시 로그인 후 시도해주세요.',
      );
    }

    try {
      await user.delete();
    } on fb.FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        AppLog.i('재인증 시도...');
        await reauth();
        await user.delete();
      } else {
        rethrow;
      }
    }
  }
}
