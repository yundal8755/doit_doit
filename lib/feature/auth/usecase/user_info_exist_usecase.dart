import 'package:doit_doit/feature/auth/repository/auth_repository.dart';

class UserInfoExistUsecase {
  final AuthRepository repository;

  UserInfoExistUsecase(this.repository);

  Future<bool> call(String? uid) async {
    return await repository.isFirstLogin(uid ?? '');
  }
}
