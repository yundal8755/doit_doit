import 'package:doit_doit/feature/auth/entity/user_entity.dart';
import 'package:doit_doit/feature/user/dto/user_dto.dart';

abstract interface class UserRepository {
  ///
  /// 회원가입
  ///
  Future<void> createUser(UserDto dto);

  ///
  /// 유저 정보 불러오기
  ///
  Future<UserEntity?> fetchUser(String platformUuid);
}
