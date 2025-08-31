import 'package:doit_doit/feature/user/entity/user_entity.dart';
import 'package:doit_doit/feature/user/repository/user_repository.dart';

///
/// 현재 유저의 정보를 UserEntity 형태로 전달하는 Usecase
///
class FetchUserInfoUsecase {
  final UserRepository repository;

  FetchUserInfoUsecase(this.repository);

  Future<UserEntity?> call(String platformUuid) {
    return repository.fetchUser(platformUuid);
  }
}
