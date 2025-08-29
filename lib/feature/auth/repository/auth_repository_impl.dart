import 'package:doit_doit/feature/auth/datasource/auth_remote_datasource.dart';
import 'package:doit_doit/feature/auth/entity/user_entity.dart';
import 'package:doit_doit/feature/auth/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<UserEntity?> signInWithGoogle() async {
    final dto = await remote.signInWithGoogle();
    return dto?.toEntity();
  }

  @override
  Future<void> signOut() async {
    await remote.signOut();
  }
}
