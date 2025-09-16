import 'package:doit_doit/feature/todo/entity/todo_entity.dart';
import 'package:doit_doit/presentation/provider/todo/fetch_todo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin class TodoState {
  AsyncValue<List<TodoEntity?>> fetchAsync(WidgetRef ref) =>
      ref.watch(fetchTodoProvider);
}
