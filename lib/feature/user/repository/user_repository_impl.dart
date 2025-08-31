import 'package:doit_doit/feature/auth/entity/user_entity.dart';
import 'package:doit_doit/feature/user/datasource/remote/user_remote_datasource.dart';
import 'package:doit_doit/feature/user/dto/user_dto.dart';
import 'package:doit_doit/feature/user/repository/user_repository.dart';

final class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource _remote;

  UserRepositoryImpl(this._remote);

  @override
  Future<void> createUser(UserDto dto) async {
    return _remote.createUser(dto);
  }

  @override
  Future<UserEntity?> fetchUser(String platformUuid) async {
    final dto = await _remote.fetchUser(platformUuid);

    // dto -> entity
    final userEntity = UserEntity(
      userId: dto?.platformUuid,
      nickname: dto?.nickname,
    );
    return userEntity;
  }
}
