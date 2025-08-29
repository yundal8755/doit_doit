import 'package:doit_doit/feature/auth/datasource/auth_remote_datasource.dart';
import 'package:doit_doit/feature/auth/entity/user_entity.dart';
import 'package:doit_doit/feature/auth/repository/auth_repository.dart';
import 'package:doit_doit/feature/auth/repository/auth_repository_impl.dart';
import 'package:doit_doit/feature/auth/usecase/sign_in_with_google_usecase.dart';
import 'package:doit_doit/feature/auth/usecase/sign_out_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ✅ DataSource Provider
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource();
});

/// ✅ Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read(authRemoteDataSourceProvider));
});

/// ✅ UseCase Providers
final signInWithGoogleUseCaseProvider =
    Provider<SignInWithGoogleUseCase>((ref) {
  return SignInWithGoogleUseCase(ref.read(authRepositoryProvider));
});

final signOutUseCaseProvider = Provider<SignOutUseCase>((ref) {
  return SignOutUseCase(ref.read(authRepositoryProvider));
});

/// ✅ 로그인 상태 Provider (Future 상태 관리)
final googleSignInProvider =
    FutureProvider.autoDispose<UserEntity?>((ref) async {
  final usecase = ref.read(signInWithGoogleUseCaseProvider);
  return await usecase();
});
