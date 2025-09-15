class TodoEntity {
  final String title;
  final String? description;
  final String priority;
  final String status;
  final DateTime? dueDate;
  final DateTime createdAt;
  final DateTime? completedAt;
  final DateTime? lastModified;

  TodoEntity({
    required this.title,
    this.description,
    required this.priority,
    required this.status,
    this.dueDate,
    required this.createdAt,
    this.completedAt,
    this.lastModified,
  });
}
