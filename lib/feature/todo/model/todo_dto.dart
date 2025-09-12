import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_doit/feature/todo/entity/todo_entity.dart';

///
/// TODO : fetch_todo_list_model로 대체 예정
///
class TodoDto {
  final String id;
  final String title;
  final String? description;
  final String priority;
  final String status;
  final DateTime? dueDate;
  final DateTime createdAt;
  final DateTime? completedAt;
  final DateTime? lastModified;

  TodoDto({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.dueDate,
    required this.createdAt,
    this.completedAt,
    this.lastModified,
  });

  /// Firestore → TodoDto 변환
  factory TodoDto.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return TodoDto(
      id: snapshot.id,
      title: data['title'] as String,
      description: data['description'] as String?, // nullable
      priority: data['priority'] as String,
      status: data['status'] as String,
      dueDate: (data['dueDate'] as Timestamp?)?.toDate(), // nullable
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      completedAt: (data['completedAt'] as Timestamp?)?.toDate(),
      lastModified: (data['lastModified'] as Timestamp?)?.toDate(),
    );
  }

  /// Entity → DTO 변환
  factory TodoDto.fromEntity(TodoEntity entity) {
    return TodoDto(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      priority: entity.priority,
      status: entity.status,
      dueDate: entity.dueDate,
      createdAt: entity.createdAt,
      completedAt: entity.completedAt,
      lastModified: entity.lastModified,
    );
  }

  /// Firestore에 저장할 때 사용
  Map<String, dynamic> toFirestore() {
    return {
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

  /// DTO → Entity 변환
  TodoEntity toEntity() {
    return TodoEntity(
      id: id,
      title: title,
      description: description,
      priority: priority,
      status: status,
      dueDate: dueDate,
      createdAt: createdAt,
      completedAt: completedAt,
      lastModified: lastModified,
    );
  }
}
