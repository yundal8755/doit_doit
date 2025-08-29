class ProjectEntity {
  final String id;
  final String title;
  final String description;
  final String theme;
  final DateTime createdAt;
  final DateTime dueDate;
  final DateTime? completedAt;
  final bool isCompleted;
  // TaskEntity 추가하기

  const ProjectEntity(
    this.theme,
    this.createdAt,
    this.dueDate,
    this.completedAt,
    this.isCompleted, {
    required this.id,
    required this.title,
    required this.description,
  });
}
