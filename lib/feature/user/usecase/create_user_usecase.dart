import 'package:doit_doit/feature/user/dto/user_dto.dart';
import 'package:doit_doit/feature/user/repository/user_repository.dart';

///
/// 입력한 정보를 바탕으로 회원가입하는 로직
///
class CreateUserUsecase {
  final UserRepository repository;

  CreateUserUsecase(this.repository);

  Future<void> call(UserDto dto) {
    return repository.createUser(dto);
  }
}
