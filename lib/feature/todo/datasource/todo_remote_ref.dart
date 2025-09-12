import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_doit/app/environment/firebase_ref.dart';
import 'package:doit_doit/feature/todo/model/create_todo_model.dart';
import 'package:doit_doit/feature/todo/model/todo_dto.dart';

abstract class FirestoreTodosRef {
  ///
  /// 할 일 서브 컬렉션
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
  /// 새로운 할 일 문서 생성
  ///
  static Future<void> create({
    required String userId,
    required CreateTodoModel request,
  }) async {
    final docRef = collection(userId).doc();

    // TODO : TodoDto 삭제 후 CreateTodoModel로 대체
    final dto = TodoDto(
      id: docRef.id,
      title: request.title,
      description: request.description,
      priority: request.priority, // e.g. 'low' | 'normal' | 'high'
      status: 'ongoing',
      createdAt: DateTime.now(),
      dueDate: request.dueDate,
      completedAt: null,
      lastModified: DateTime.now(),
    );

    await docRef.set(dto);
  }
}
