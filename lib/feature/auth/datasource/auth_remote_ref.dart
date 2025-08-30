import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_doit/feature/auth/datasource/dto/user_dto.dart';

abstract class FirestoreUsersRef {
  static const String collectionName = 'users';

  ///
  /// users 컬렉션
  ///
  static CollectionReference<UserDto> collection() =>
      FirebaseFirestore.instance.collection(collectionName).withConverter(
            fromFirestore: UserDto.fromFirestore,
            toFirestore: (user, _) => user.toFirestore(),
          );

  ///
  /// 특정 유저 문서
  ///
  static DocumentReference<UserDto> doc(String userId) =>
      FirebaseFirestore.instance
          .collection(collectionName)
          .doc(userId)
          .withConverter(
            fromFirestore: UserDto.fromFirestore,
            toFirestore: (user, _) => user.toFirestore(),
          );
}
