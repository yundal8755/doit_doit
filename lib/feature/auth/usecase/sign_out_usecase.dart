import 'package:doit_doit/feature/auth/repository/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<void> call() async {
    return await repository.signOut();
  }
}
