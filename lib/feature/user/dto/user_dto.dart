import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:doit_doit/app/enum/social_login_platform.dart';

///
/// 소셜 계정으로 회원가입시 Firestore에 저장하는 정보
///
class UserDto {
  final String nickname;
  final SocialLoginPlatform signUpPlatform; // 가입한 소셜 플랫폼
  final String platformUuid; // 소셜 플랫폼에서 발급받은 uid

  UserDto({
    required this.nickname,
    required this.signUpPlatform,
    required this.platformUuid,
  });

  /// Firebase User → UserDto 변환
  factory UserDto.fromFirebaseUser(User user, SocialLoginPlatform platform) {
    return UserDto(
      nickname: user.displayName ?? '',
      signUpPlatform: platform,
      platformUuid: user.uid,
    );
  }

  /// Firestore → UserDto 변환
  factory UserDto.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return UserDto(
      nickname: data['nickname'] as String? ?? '',
      signUpPlatform: SocialLoginPlatform.values.firstWhere(
        (e) => e.name == (data['signUpPlatform'] as String? ?? ''),
        orElse: () => SocialLoginPlatform.google, // 기본값 (필요시 수정)
      ),
      platformUuid: data['platformUuid'] as String? ?? '',
    );
  }

  /// UserDto → Firestore Map 변환
  Map<String, dynamic> toFirestore() {
    return {
      'nickname': nickname,
      'signUpPlatform': signUpPlatform.name,
      'platformUuid': platformUuid,
    };
  }
}
