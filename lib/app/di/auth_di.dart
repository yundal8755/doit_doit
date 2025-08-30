import 'package:doit_doit/feature/auth/usecase/sign_in_oauth_usecase.dart';
import 'package:doit_doit/feature/auth/usecase/user_info_exist_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:doit_doit/feature/auth/datasource/auth_remote_datasource_impl.dart';
import 'package:doit_doit/feature/auth/repository/auth_repository.dart';
import 'package:doit_doit/feature/auth/repository/auth_repository_impl.dart';
import 'package:doit_doit/feature/auth/usecase/sign_out_usecase.dart';

part 'auth_di.g.dart';

///
/// 1) DataSource
///
@riverpod
AuthRemoteDataSourceImpl authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSourceImpl();
}

///
/// 2) Repository
///
@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.watch(authRemoteDataSourceProvider));
}

///
/// 3) UseCases
///
@riverpod
SignOutUseCase signOutUseCase(Ref ref) {
  return SignOutUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
UserInfoExistUsecase userInfoExistUsecase(Ref ref) {
  return UserInfoExistUsecase(ref.watch(authRepositoryProvider));
}

@riverpod
SignInOauthUsecase signInOauthUsecase(Ref ref) {
  return SignInOauthUsecase(ref.watch(authRepositoryProvider));
}



///
/// TODO: user.di로 옮길 예정
///
// @riverpod
// SignInWithGoogleUseCase signInWithGoogleUseCase(Ref ref) {
//   return SignInWithGoogleUseCase(ref.watch(authRepositoryProvider));
// }

// @riverpod
// GetCurrentUserInfoUsecase getCurrentUserInfoUseCase(Ref ref) {
//   return GetCurrentUserInfoUsecase(ref.watch(authRepositoryProvider));
// }