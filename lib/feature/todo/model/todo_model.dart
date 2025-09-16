import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_doit/feature/todo/entity/todo_entity.dart';

class TodoModel {
  final String? id;
  final String title;
  final String? description;
  final String priority;
  final bool isComplete;
  final DateTime createdAt;

  TodoModel._({
    required this.id,
    required this.title,
    this.description,
    required this.priority,
    required this.isComplete,
    required this.createdAt,
  });

  /// 생성 시엔 id 없음(문서 생성 후 생김)
  factory TodoModel({
    String? id,
    required String title,
    required String priority,
    String? description,
    bool isComplete = false,
  }) {
    return TodoModel._(
      id: id,
      title: title,
      description: description,
      priority: priority,
      isComplete: isComplete,
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
      throw StateError('TodoModel snapshot has null data (id=${doc.id})');
    }

    final createdAtRaw = data['createdAt'];
    final createdAt = createdAtRaw is Timestamp
        ? createdAtRaw.toDate()
        : (createdAtRaw is DateTime ? createdAtRaw : DateTime.now());

    return TodoModel._(
      id: doc.id, // ← 여기서 문서 id 주입 (데이터에 별도 id 필드 없음)
      title: (data['title'] as String?) ?? '',
      description: data['description'] as String?,
      priority: (data['priority'] as String?) ?? '긴급',
      isComplete: (data['isComplete'] as bool?) ?? false,
      createdAt: createdAt,
    );
  }

  /// Model -> Firestore (id는 저장하지 않음)
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'priority': priority,
      'isComplete': isComplete,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  /// 선택: 편의용
  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    String? priority,
    bool? isComplete,
    DateTime? createdAt,
  }) {
    return TodoModel._(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      isComplete: isComplete ?? this.isComplete,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Model -> Entity (Entity에 id가 있다면 매핑)
  TodoEntity toEntity() {
    return TodoEntity(
      id: id,
      title: title,
      description: description,
      priority: priority,
      isComplete: isComplete,
      createdAt: createdAt,
    );
  }

  @override
  String toString() {
    return 'TodoModel\n title: $title,\n description: $description,\n priority: $priority,\n isComplete: $isComplete';
  }
}
