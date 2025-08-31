import 'package:doit_doit/feature/auth/repository/auth_repository.dart';

///
/// Firestore에 유저 정보가 있는지 확인하는 로직
///
class UserInfoExistUsecase {
  final AuthRepository repository;

  UserInfoExistUsecase(this.repository);

  Future<bool> call(String? uid) async {
    return await repository.isFirstLogin(uid ?? '');
  }
}
