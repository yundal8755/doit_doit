// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoHash() => r'db823d9ab18b89c08d22153ff4517c07a8a33ddd';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$Todo
    extends BuildlessAutoDisposeAsyncNotifier<List<TodoEntity?>> {
  late final String userId;

  FutureOr<List<TodoEntity?>> build(
    String userId,
  );
}

/// See also [Todo].
@ProviderFor(Todo)
const todoProvider = TodoFamily();

/// See also [Todo].
class TodoFamily extends Family<AsyncValue<List<TodoEntity?>>> {
  /// See also [Todo].
  const TodoFamily();

  /// See also [Todo].
  TodoProvider call(
    String userId,
  ) {
    return TodoProvider(
      userId,
    );
  }

  @override
  TodoProvider getProviderOverride(
    covariant TodoProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'todoProvider';
}

/// See also [Todo].
class TodoProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Todo, List<TodoEntity?>> {
  /// See also [Todo].
  TodoProvider(
    String userId,
  ) : this._internal(
          () => Todo()..userId = userId,
          from: todoProvider,
          name: r'todoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$todoHash,
          dependencies: TodoFamily._dependencies,
          allTransitiveDependencies: TodoFamily._allTransitiveDependencies,
          userId: userId,
        );

  TodoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  FutureOr<List<TodoEntity?>> runNotifierBuild(
    covariant Todo notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(Todo Function() create) {
    return ProviderOverride(
      origin: this,
      override: TodoProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Todo, List<TodoEntity?>>
      createElement() {
    return _TodoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TodoProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TodoRef on AutoDisposeAsyncNotifierProviderRef<List<TodoEntity?>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _TodoProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Todo, List<TodoEntity?>>
    with TodoRef {
  _TodoProviderElement(super.provider);

  @override
  String get userId => (origin as TodoProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
