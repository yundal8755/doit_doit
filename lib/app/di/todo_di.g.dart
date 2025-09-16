// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoRemoteDatasourceHash() =>
    r'b0e1d6a807f4556fdecb7ad16a98b80428b6cba9';

///
/// DataSource
///
///
/// Copied from [todoRemoteDatasource].
@ProviderFor(todoRemoteDatasource)
final todoRemoteDatasourceProvider =
    AutoDisposeProvider<TodoRemoteDatasource>.internal(
  todoRemoteDatasource,
  name: r'todoRemoteDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoRemoteDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodoRemoteDatasourceRef = AutoDisposeProviderRef<TodoRemoteDatasource>;
String _$todoRepositoryHash() => r'9b7dd5ec9ac210b690e287af91cf066b5216ee6b';

///
/// Repository
///
///
/// Copied from [todoRepository].
@ProviderFor(todoRepository)
final todoRepositoryProvider = AutoDisposeProvider<TodoRepository>.internal(
  todoRepository,
  name: r'todoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodoRepositoryRef = AutoDisposeProviderRef<TodoRepository>;
String _$fetchTodoListUsecaseHash() =>
    r'512361f3eb2bd14c0071e4098f5dae0ef10dee32';

///
/// Usecase
///
///
/// Copied from [fetchTodoListUsecase].
@ProviderFor(fetchTodoListUsecase)
final fetchTodoListUsecaseProvider =
    AutoDisposeProvider<FetchTodoListUsecase>.internal(
  fetchTodoListUsecase,
  name: r'fetchTodoListUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchTodoListUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchTodoListUsecaseRef = AutoDisposeProviderRef<FetchTodoListUsecase>;
String _$createTodoUsecaseHash() => r'dfc464846fe037a4cddf48ae5f90281c119df749';

/// See also [createTodoUsecase].
@ProviderFor(createTodoUsecase)
final createTodoUsecaseProvider =
    AutoDisposeProvider<CreateTodoUsecase>.internal(
  createTodoUsecase,
  name: r'createTodoUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$createTodoUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CreateTodoUsecaseRef = AutoDisposeProviderRef<CreateTodoUsecase>;
String _$deleteTodoUsecaseHash() => r'5773080e177a5389a41b13f7713eb8c4aa50b83e';

/// See also [deleteTodoUsecase].
@ProviderFor(deleteTodoUsecase)
final deleteTodoUsecaseProvider =
    AutoDisposeProvider<DeleteTodoUsecase>.internal(
  deleteTodoUsecase,
  name: r'deleteTodoUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deleteTodoUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DeleteTodoUsecaseRef = AutoDisposeProviderRef<DeleteTodoUsecase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
