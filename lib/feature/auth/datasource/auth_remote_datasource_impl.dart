import 'package:doit_doit/feature/auth/datasource/auth_remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl({
    FirebaseAuth? auth,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  ///
  /// Google 로그인
  ///
  @override
  Future<UserCredential?> signInWithGoogle() async {
    // 구글 계정 선택
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    // 토큰 획득
    final googleAuth = await googleUser.authentication;

    // Firebase Auth 인증
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    // final firebaseUser = userCredential.user;
    // if (firebaseUser == null) return null;

    return userCredential;
  }

  ///
  /// Apple 로그인
  ///
  @override
  Future<UserCredential?> signInWithApple() async {
    // 사용자가 Apple 계정을 통해 로그인하면 받아오는 인증 정보
    final appleIdCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // FirebaseAuth에 전달할 OAuth 자격 증명
    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleIdCredential.identityToken,
      accessToken: appleIdCredential.authorizationCode,
    );

    // Firebase Auth 로그인
    final userCredential = await _auth.signInWithCredential(oauthCredential);
    return userCredential;
  }

  ///
  /// 로그아웃
  ///
  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
