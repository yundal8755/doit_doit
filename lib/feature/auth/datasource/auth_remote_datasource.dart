import 'package:doit_doit/feature/auth/dto/user_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSource({
    FirebaseAuth? auth,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  /// Google 로그인
  Future<UserDto?> signInWithGoogle() async {
    // 1️⃣ 구글 계정 선택
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    // 2️⃣ 토큰 획득
    final googleAuth = await googleUser.authentication;

    // 3️⃣ Firebase Auth 인증
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    final firebaseUser = userCredential.user;
    if (firebaseUser == null) return null;

    return UserDto.fromFirebaseUser(firebaseUser);
  }

  /// 로그아웃
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
