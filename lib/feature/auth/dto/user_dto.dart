import 'package:doit_doit/feature/auth/entity/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDto {
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;

  UserDto({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoUrl,
  });

  /// Firebase User → UserDto 변환
  factory UserDto.fromFirebaseUser(User user) {
    return UserDto(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
      photoUrl: user.photoURL ?? '',
    );
  }

  /// DTO → Domain Entity 변환
  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }
}
