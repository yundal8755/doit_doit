import 'package:doit_doit/feature/auth/entity/user_entity.dart';
import 'package:doit_doit/feature/auth/repository/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository repository;

  SignInWithGoogleUseCase(this.repository);

  Future<UserEntity?> call() async {
    return await repository.signInWithGoogle();
  }
}
