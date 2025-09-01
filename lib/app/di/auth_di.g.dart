// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRemoteDataSourceHash() =>
    r'ec3b7de612d25aa4d9fb4c66d76b8b8d96386167';

///
/// DataSource
///
///
/// Copied from [authRemoteDataSource].
@ProviderFor(authRemoteDataSource)
final authRemoteDataSourceProvider =
    AutoDisposeProvider<AuthRemoteDataSourceImpl>.internal(
  authRemoteDataSource,
  name: r'authRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRemoteDataSourceRef
    = AutoDisposeProviderRef<AuthRemoteDataSourceImpl>;
String _$authRepositoryHash() => r'87396bbc29e604ed15ee440f11a409ca5b2d6bfd';

///
/// Repository
///
///
/// Copied from [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = AutoDisposeProvider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = AutoDisposeProviderRef<AuthRepository>;
String _$signOutUseCaseHash() => r'952ce342ca22dc7bb696cc8e5787d2889240ef98';

///
/// UseCase
///
///
/// Copied from [signOutUseCase].
@ProviderFor(signOutUseCase)
final signOutUseCaseProvider = AutoDisposeProvider<SignOutUseCase>.internal(
  signOutUseCase,
  name: r'signOutUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$signOutUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SignOutUseCaseRef = AutoDisposeProviderRef<SignOutUseCase>;
String _$userInfoExistUsecaseHash() =>
    r'ded19a14056e5167b7af7970ad1cf9bf747fb9ab';

/// See also [userInfoExistUsecase].
@ProviderFor(userInfoExistUsecase)
final userInfoExistUsecaseProvider =
    AutoDisposeProvider<UserInfoExistUsecase>.internal(
  userInfoExistUsecase,
  name: r'userInfoExistUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userInfoExistUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserInfoExistUsecaseRef = AutoDisposeProviderRef<UserInfoExistUsecase>;
String _$signInOauthUsecaseHash() =>
    r'4fa577fe9b3af141a40f3059a66e49e2bd3bffba';

/// See also [signInOauthUsecase].
@ProviderFor(signInOauthUsecase)
final signInOauthUsecaseProvider =
    AutoDisposeProvider<SignInOauthUsecase>.internal(
  signInOauthUsecase,
  name: r'signInOauthUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$signInOauthUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SignInOauthUsecaseRef = AutoDisposeProviderRef<SignInOauthUsecase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
