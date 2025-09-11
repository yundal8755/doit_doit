import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_doit/app/environment/firebase_ref.dart';
import 'package:doit_doit/feature/todo/dto/todo_dto.dart';

abstract class FirestoreTodosRef {
  ///
  /// 컬렉션
  ///
  static CollectionReference<TodoDto> collection(String userId) =>
      FirebaseFirestore.instance
          .collection(FirestoreRef.usersCollection)
          .doc(userId)
          .collection(FirestoreRef.todosSubCollection)
          .withConverter(
            fromFirestore: TodoDto.fromFirestore,
            toFirestore: (todo, _) => todo.toFirestore(),
          );

  ///
  /// 특정 할 일 문서
  ///
  static DocumentReference<TodoDto> doc(
          {required String userId, required String todoId}) =>
      FirebaseFirestore.instance
          .collection(FirestoreRef.usersCollection)
          .doc(userId)
          .collection(FirestoreRef.todosSubCollection)
          .doc(todoId)
          .withConverter(
            fromFirestore: TodoDto.fromFirestore,
            toFirestore: (todo, _) => todo.toFirestore(),
          );
}
