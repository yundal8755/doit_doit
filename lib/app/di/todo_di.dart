import 'package:doit_doit/feature/todo/datasource/todo_remote_datasource.dart';
import 'package:doit_doit/feature/todo/datasource/todo_remote_datasource_impl.dart';
import 'package:doit_doit/feature/todo/repository/todo_repository.dart';
import 'package:doit_doit/feature/todo/repository/todo_repository_impl.dart';
import 'package:doit_doit/feature/todo/usecase/create_todo_usecase.dart';
import 'package:doit_doit/feature/todo/usecase/delete_todo_usecase.dart';
import 'package:doit_doit/feature/todo/usecase/fetch_todo_list_usecase.dart';
import 'package:doit_doit/feature/todo/usecase/update_todo_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_di.g.dart';

///
/// DataSource
///
@riverpod
TodoRemoteDatasource todoRemoteDatasource(Ref ref) {
  return TodoRemoteDatasourceImpl();
}

///
/// Repository
///
@riverpod
TodoRepository todoRepository(Ref ref) {
  return TodoRepositoryImpl(ref.watch(todoRemoteDatasourceProvider));
}

///
/// Usecase
///
@riverpod
FetchTodoListUsecase fetchTodoListUsecase(Ref ref) {
  return FetchTodoListUsecase(ref.watch(todoRepositoryProvider));
}

@riverpod
CreateTodoUsecase createTodoUsecase(Ref ref) {
  return CreateTodoUsecase(ref.watch(todoRepositoryProvider));
}

@riverpod
DeleteTodoUsecase deleteTodoUsecase(Ref ref) {
  return DeleteTodoUsecase(ref.watch(todoRepositoryProvider));
}

@riverpod
UpdateTodoUsecase updateTodoUsecase(Ref ref) {
  return UpdateTodoUsecase(ref.watch(todoRepositoryProvider));
}
