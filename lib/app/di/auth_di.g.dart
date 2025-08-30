// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRemoteDataSourceHash() =>
    r'ec3b7de612d25aa4d9fb4c66d76b8b8d96386167';

///
/// 1) DataSource
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
/// 2) Repository
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
String _$signInWithGoogleUseCaseHash() =>
    r'665c8b7cec97ca0c16454bfd4072aeac9e931ed9';

///
/// 3) UseCases
///
///
/// Copied from [signInWithGoogleUseCase].
@ProviderFor(signInWithGoogleUseCase)
final signInWithGoogleUseCaseProvider =
    AutoDisposeProvider<SignInWithGoogleUseCase>.internal(
  signInWithGoogleUseCase,
  name: r'signInWithGoogleUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$signInWithGoogleUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SignInWithGoogleUseCaseRef
    = AutoDisposeProviderRef<SignInWithGoogleUseCase>;
String _$signOutUseCaseHash() => r'952ce342ca22dc7bb696cc8e5787d2889240ef98';

/// See also [signOutUseCase].
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
String _$getCurrentUserInfoUseCaseHash() =>
    r'e0645b6dd5597f307da89b07c24708749869fa40';

/// See also [getCurrentUserInfoUseCase].
@ProviderFor(getCurrentUserInfoUseCase)
final getCurrentUserInfoUseCaseProvider =
    AutoDisposeProvider<GetCurrentUserInfoUsecase>.internal(
  getCurrentUserInfoUseCase,
  name: r'getCurrentUserInfoUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getCurrentUserInfoUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetCurrentUserInfoUseCaseRef
    = AutoDisposeProviderRef<GetCurrentUserInfoUsecase>;
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
