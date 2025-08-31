import 'package:doit_doit/feature/user/datasource/remote/user_remote_datasource_impl.dart';
import 'package:doit_doit/feature/user/repository/user_repository_impl.dart';
import 'package:doit_doit/feature/user/usecase/create_user_usecase.dart';
import 'package:doit_doit/feature/user/usecase/fetch_user_info_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_di.g.dart';

///
/// DataSource
///
@riverpod
UserRemoteDatasourceImpl userRemoteDatasource(Ref ref) {
  return UserRemoteDatasourceImpl();
}

///
/// Repository
///
@riverpod
UserRepositoryImpl userRepository(Ref ref) {
  return UserRepositoryImpl(ref.watch(userRemoteDatasourceProvider));
}

///
/// Usecase
///
@riverpod
FetchUserInfoUsecase fetchUserInfoUsecase(Ref ref) {
  return FetchUserInfoUsecase(ref.watch(userRepositoryProvider));
}

@riverpod
CreateUserUsecase createUserUsecase(Ref ref) {
  return CreateUserUsecase(ref.watch(userRepositoryProvider));
}
