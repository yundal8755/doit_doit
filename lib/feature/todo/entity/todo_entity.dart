class TodoEntity {
  final String? id;
  final String title;
  final String? description;
  final String priority;
  final bool isComplete;
  final DateTime? dueDate;
  final DateTime createdAt;
  final DateTime? completedAt;
  final DateTime? lastModified;

  TodoEntity({
    this.id,
    required this.title,
    this.description,
    required this.priority,
    required this.isComplete,
    this.dueDate,
    required this.createdAt,
    this.completedAt,
    this.lastModified,
  });

  @override
  String toString() {
    return 'TodoEntity(id: $id, title: $title, description: $description, '
        'priority: $priority, isComplete: $isComplete, createdAt: $createdAt)';
  }
}
