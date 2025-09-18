import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_doit/app/environment/firebase_ref.dart';
import 'package:doit_doit/feature/user/datasource/remote/user_remote_datasource.dart';
import 'package:doit_doit/feature/user/datasource/remote/user_remote_ref.dart';
import 'package:doit_doit/feature/user/dto/user_dto.dart';

final class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  @override
  Future<void> createUser(UserDto dto) async {
    try {
      await FirestoreUsersRef.doc(dto.platformUuid).set(dto);
    } catch (e) {
      // 로깅 또는 에러 핸들링
      rethrow;
    }
  }

  @override
  Future<UserDto?> fetchUser(String platformUuid) async {
    final snapshot = await FirestoreUsersRef.doc(platformUuid).get();
    return snapshot.data();
  }

  @override
  Future<void> deleteUser(String platformUuid) async {
    final userDocRef = FirebaseFirestore.instance
        .collection(FirestoreRef.usersCollection)
        .doc(platformUuid);

    // 1) todos 서브컬렉션 전부 삭제 (필요 시 다른 서브컬렉션도 동일 패턴으로 추가)
    final todosRef = userDocRef.collection(FirestoreRef.todosSubCollection);
    await _deleteCollectionInBatches(todosRef, batchSize: 350);

    // 2) 최종 유저 문서 삭제
    await userDocRef.delete();
  }

  Future<void> _deleteCollectionInBatches(
    CollectionReference<Map<String, dynamic>> col, {
    int batchSize = 350,
  }) async {
    while (true) {
      final snap = await col.limit(batchSize).get();
      if (snap.docs.isEmpty) break;
      final batch = FirebaseFirestore.instance.batch();
      for (final d in snap.docs) {
        batch.delete(d.reference);
      }
      await batch.commit();
      // 너무 빠른 루프 방지 (파이어스토어 제한 회피용)
      await Future<void>.delayed(const Duration(milliseconds: 50));
    }
  }
}
