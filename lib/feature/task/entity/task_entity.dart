class TaskEntity {
  final String id;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime? completedAt;
  final DateTime createdAt;
  final String? projectId;

  const TaskEntity(
    this.completedAt,
    this.projectId,
    this.createdAt, {
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });
}
