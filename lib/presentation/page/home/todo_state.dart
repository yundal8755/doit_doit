import 'package:doit_doit/app/util/app_typedef.dart';
import 'package:doit_doit/presentation/provider/todo/fetch_todo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin class TodoState {
  AsyncValue<TodoBuckets> fetchAsync(WidgetRef ref) =>
      ref.watch(fetchTodoProvider);
}
