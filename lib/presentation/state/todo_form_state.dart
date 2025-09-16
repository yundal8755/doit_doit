import 'package:flutter/foundation.dart';
import 'package:doit_doit/feature/todo/model/todo_model.dart';

@immutable
class TodoFormState {
  final String title;
  final String? description;
  final String priority;
  final bool isComplete;

  const TodoFormState({
    required this.title,
    this.description,
    required this.priority,
    this.isComplete = false, // 기본값 false
  });

  // 편의 생성자
  factory TodoFormState.fromRaw({
    required String title,
    String? description,
    required String priority,
    bool isComplete = false,
  }) {
    return TodoFormState(
      title: title,
      description: description,
      priority: priority,
      isComplete: isComplete,
    );
  }

  bool get isValid => title.trim().isNotEmpty;

  // 유즈케이스 요청 모델로 변환
  TodoModel toRequest() => TodoModel(
        title: title.trim(),
        description: description,
        priority: priority,
        isComplete: isComplete,
      );

  TodoFormState copyWith({
    String? title,
    String? description,
    String? priority,
    bool? isComplete,
  }) {
    return TodoFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  @override
  String toString() {
    return 'title: $title,\n description: $description,\n priority: $priority,\n isComplete: $isComplete';
  }
}
