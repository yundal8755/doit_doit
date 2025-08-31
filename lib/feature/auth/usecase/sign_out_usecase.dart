import 'package:doit_doit/feature/auth/repository/auth_repository.dart';

///
/// 로그아웃 기능 구현
///
class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<void> call() async {
    return await repository.signOut();
  }
}
