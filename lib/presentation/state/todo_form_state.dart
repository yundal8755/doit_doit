// lib/presentation/page/home/create_todo_state.dart
import 'package:flutter/foundation.dart';
import 'package:doit_doit/app/enum/status_enum.dart';
import 'package:doit_doit/feature/todo/model/todo_model.dart';

@immutable
class TodoFormState {
  final String title;
  final String? description;
  final String priority;
  final String status;

  const TodoFormState({
    required this.title,
    this.description,
    required this.priority,
    required this.status,
  });

  // 편의 생성자: UI의 boolean을 Status value로 매핑
  factory TodoFormState.fromRaw({
    required String title,
    String? description,
    required String priority,
    required bool isStatusOnGoing,
  }) {
    return TodoFormState(
      title: title,
      description: description,
      priority: priority,
      status: isStatusOnGoing ? Status.ongoing.value : Status.completed.value,
    );
  }

  bool get isValid => title.trim().isNotEmpty;

  // 유즈케이스 요청 모델로 변환
  TodoModel toRequest() => TodoModel(
        title: title.trim(),
        description: description,
        priority: priority,
        status: status,
      );

  TodoFormState copyWith({
    String? title,
    String? description,
    String? priority,
    String? statusValue,
  }) {
    return TodoFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: statusValue ?? status,
    );
  }
}
