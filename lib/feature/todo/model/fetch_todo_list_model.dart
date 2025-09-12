import 'package:cloud_firestore/cloud_firestore.dart';

class FetchTodoListModel {
  final String id;
  final String title;
  final String? description;
  final String priority;
  final String status;
  final DateTime createdAt;
  final DateTime? dueDate;
  final DateTime? completedAt;
  final DateTime? lastModified;

  const FetchTodoListModel({
    required this.id,
    required this.title,
    this.description,
    required this.priority,
    required this.status,
    required this.createdAt,
    this.dueDate,
    this.completedAt,
    this.lastModified,
  });

  factory FetchTodoListModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return FetchTodoListModel(
      id: snapshot.id,
      title: data['title'] as String,
      description: data['description'] as String?,
      priority: data['priority'] as String,
      status: data['status'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      dueDate: (data['dueDate'] as Timestamp?)?.toDate(),
      completedAt: (data['completedAt'] as Timestamp?)?.toDate(),
      lastModified: (data['lastModified'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'priority': priority,
        'status': status,
        'createdAt': Timestamp.fromDate(createdAt),
        'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
        'completedAt':
            completedAt != null ? Timestamp.fromDate(completedAt!) : null,
        'lastModified':
            lastModified != null ? Timestamp.fromDate(lastModified!) : null,
      };
}
