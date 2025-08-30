import 'package:doit_doit/feature/auth/entity/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDto {
  final String id;
  final String email;
  final String nickname;
  final String profileImageUrl;

  UserDto({
    required this.id,
    required this.email,
    required this.nickname,
    required this.profileImageUrl,
  });

  /// Firebase User → UserDto 변환
  factory UserDto.fromFirebaseUser(User user) {
    return UserDto(
      id: user.uid,
      email: user.email ?? '',
      nickname: user.displayName ?? '',
      profileImageUrl: user.photoURL ?? '',
    );
  }

  /// Firestore → UserDto 변환
  factory UserDto.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return UserDto(
      id: snapshot.id, // Firestore 문서 id를 그대로 UserDto.id에 반영
      email: data['email'] as String? ?? '',
      nickname: data['nickname'] as String? ?? '',
      profileImageUrl: data['profileImageUrl'] as String? ?? '',
    );
  }

  /// UserDto → Firestore Map 변환
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'nickname': nickname,
      'profileImageUrl': profileImageUrl,
    };
  }

  /// DTO → Domain Entity 변환
  UserEntity toEntity() {
    return UserEntity(
      userId: id,
      email: email,
      nickname: nickname,
      profileImageUrl: profileImageUrl,
    );
  }
}
