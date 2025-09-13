// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_todo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createTodoHash() => r'760fcad6c78cfa5dc808ef73ba5d78d0b7e2e4e4';

/// 버튼 탭 → 제출 중 로딩/성공/에러를 표현
///
/// Copied from [CreateTodo].
@ProviderFor(CreateTodo)
final createTodoProvider =
    AutoDisposeNotifierProvider<CreateTodo, AsyncValue<void>>.internal(
  CreateTodo.new,
  name: r'createTodoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$createTodoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CreateTodo = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
