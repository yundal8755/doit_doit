import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_doit/app/environment/firebase_ref.dart';
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/feature/todo/model/todo_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirestoreTodosRef {
  ///
  /// 할 일 서브 컬렉션
  ///
  static CollectionReference<TodoModel> collection(String userId) =>
      FirebaseFirestore.instance
          .collection(FirestoreRef.usersCollection)
          .doc(userId)
          .collection(FirestoreRef.todosSubCollection)
          .withConverter(
            fromFirestore: TodoModel.fromFirestore,
            toFirestore: (todo, _) => todo.toFirestore(),
          );

  ///
  /// 새로운 할 일 문서 생성
  ///
  static Future<void> create({
    required String userId,
    required TodoModel request,
  }) async {
    final docRef = collection(userId).doc();
    await docRef.set(request);
  }

  ///
  /// 할 일 문서 삭제
  ///
  static Future<void> delete({
    required String todoId,
  }) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      AppLog.e('User not logged in');
      return;
    }

    final docRef = collection(userId).doc(todoId);
    await docRef.delete();
  }
}
