import 'package:cloud_firestore/cloud_firestore.dart';

class CreateTodoModel {
  final String title;
  final String? description;
  final String priority;
  final String status;
  final DateTime? dueDate;
  final DateTime createdAt;
  final DateTime? completedAt;
  final DateTime? lastModified;

  CreateTodoModel._({
    required this.title,
    this.description,
    required this.priority,
    required this.status,
    this.dueDate,
    required this.createdAt,
    this.completedAt,
    this.lastModified,
  });

  /// 안전하게 생성하는 팩토리
  factory CreateTodoModel({
    required String title,
    required String status,
    required String priority,
    String? description,
    DateTime? dueDate,
    DateTime? completedAt,
  }) {
    return CreateTodoModel._(
      title: title,
      description: description,
      priority: priority,
      status: status,
      dueDate: dueDate,
      completedAt: completedAt,
      createdAt: DateTime.now(), // 자동 고정
      lastModified: null, // 자동 고정
    );
  }

  /// Firestore 직렬화
  Map<String, dynamic> toFirestore(String id) {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'status': status,
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
      'createdAt': Timestamp.fromDate(createdAt),
      'completedAt':
          completedAt != null ? Timestamp.fromDate(completedAt!) : null,
      'lastModified':
          lastModified != null ? Timestamp.fromDate(lastModified!) : null,
    };
  }
}
