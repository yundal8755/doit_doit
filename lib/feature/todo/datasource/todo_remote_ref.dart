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
  /// 할 일 추가
  ///
  static Future<void> create({
    required String userId,
    required TodoModel request,
  }) async {
    final docRef = collection(userId).doc();
    await docRef.set(request);
  }

  ///
  /// 할 일 삭제
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

  ///
  /// 할 일 업데이트
  ///
  static Future<void> update({
    required TodoModel model,
  }) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      AppLog.e('User not logged in');
      return;
    }

    AppLog.d('모델 ID : ${model.id}');

    final docRef = collection(userId).doc(model.id);
    await docRef.update({...model.toFirestore()});
  }

  ///
  /// 진행중/완료 토글 업데이트
  ///
  static Future<void> updateIsComplete({
    required TodoModel model,
  }) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      AppLog.e('User not logged in');
      return;
    }

    final docRef = collection(userId).doc(model.id);
    await docRef.update({
      'isComplete': model.isComplete,
    });
  }
}
