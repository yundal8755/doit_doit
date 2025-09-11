import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_doit/app/environment/firebase_ref.dart';
import 'package:doit_doit/feature/user/dto/user_dto.dart';

abstract class FirestoreUsersRef {
  ///
  /// users 컬렉션
  ///
  static CollectionReference<UserDto> collection() => FirebaseFirestore.instance
      .collection(FirestoreRef.usersCollection)
      .withConverter(
        fromFirestore: UserDto.fromFirestore,
        toFirestore: (user, _) => user.toFirestore(),
      );

  ///
  /// 특정 유저 문서
  ///
  static DocumentReference<UserDto> doc(String userId) =>
      FirebaseFirestore.instance
          .collection(FirestoreRef.usersCollection)
          .doc(userId)
          .withConverter(
            fromFirestore: UserDto.fromFirestore,
            toFirestore: (user, _) => user.toFirestore(),
          );
}
