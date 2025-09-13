import 'package:cloud_firestore/cloud_firestore.dart';

class CreateTodoModel {
  final String title;
  final String? description;
  final String priority;
  final String status;
  final DateTime createdAt;

  CreateTodoModel._({
    required this.title,
    this.description,
    required this.priority,
    required this.status,
    required this.createdAt,
  });

  /// 안전하게 생성하는 팩토리
  factory CreateTodoModel({
    required String title,
    required String status,
    required String priority,
    String? description,
  }) {
    return CreateTodoModel._(
      title: title,
      description: description,
      priority: priority,
      status: status,
      createdAt: DateTime.now(), // 자동 고정
    );
  }

  /// Firestore 직렬화
  Map<String, dynamic> toFirestore(String id) {
    return {
      'title': title,
      'description': description,
      'priority': priority,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
