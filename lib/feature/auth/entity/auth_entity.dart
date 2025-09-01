import 'package:firebase_auth/firebase_auth.dart';

class AuthEntity {
  final String uid;
  final String? email;
  final String? displayName;
  final String providerId;
  final bool isNewUser;

  const AuthEntity({
    required this.uid,
    this.email,
    this.displayName,
    required this.providerId,
    this.isNewUser = false,
  });

  // Firebase 전용 팩토리
  factory AuthEntity.fromFirebase(UserCredential cred) {
    final user = cred.user!;
    return AuthEntity(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      providerId: cred.credential?.providerId ?? 'firebase',
      isNewUser: cred.additionalUserInfo?.isNewUser ?? false,
    );
  }

  // // Kakao 전용 팩토리
  // factory AuthEntity.fromKakao(KakaoUser kakaoUser) {
  //   return AuthEntity(
  //     uid: kakaoUser.id.toString(),
  //     email: kakaoUser.kakaoAccount?.email,
  //     displayName: kakaoUser.kakaoAccount?.profile?.nickname,
  //     providerId: 'kakao',
  //   );
  // }

  // // Naver 전용 팩토리
  // factory AuthEntity.fromNaver(NaverUser naverUser) {
  //   return AuthEntity(
  //     uid: naverUser.id,
  //     email: naverUser.email,
  //     displayName: naverUser.name,
  //     providerId: 'naver',
  //   );
  // }
}
