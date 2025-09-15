import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_doit/feature/todo/entity/todo_entity.dart';

class TodoModel {
  final String title;
  final String? description;
  final String priority;
  final String status;
  final DateTime createdAt;

  TodoModel._({
    required this.title,
    this.description,
    required this.priority,
    required this.status,
    required this.createdAt,
  });

  /// 안전하게 생성하는 팩토리
  factory TodoModel({
    required String title,
    required String status,
    required String priority,
    String? description,
  }) {
    return TodoModel._(
      title: title,
      description: description,
      priority: priority,
      status: status,
      createdAt: DateTime.now(),
    );
  }

  /// Firestore -> Model
  static TodoModel fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = doc.data();
    if (data == null) {
      throw StateError('CreateTodoModel snapshot has null data (id=${doc.id})');
    }

    final createdAtRaw = data['createdAt'];
    final createdAt = createdAtRaw is Timestamp
        ? createdAtRaw.toDate()
        : (createdAtRaw is DateTime ? createdAtRaw : DateTime.now());

    return TodoModel._(
      title: (data['title'] as String?) ?? '',
      description: data['description'] as String?,
      priority: (data['priority'] as String?) ?? '긴급',
      status: (data['status'] as String?) ?? 'ongoing',
      createdAt: createdAt,
    );
  }

  /// Model -> Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'priority': priority,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  /// Model -> Entity
  TodoEntity toEntity() {
    return TodoEntity(
      title: title,
      description: description,
      priority: priority,
      status: status,
      createdAt: createdAt,
    );
  }
}
