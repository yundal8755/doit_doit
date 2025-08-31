import 'package:doit_doit/feature/user/datasource/remote/user_remote_datasource.dart';
import 'package:doit_doit/feature/user/datasource/remote/user_remote_ref.dart';
import 'package:doit_doit/feature/user/dto/user_dto.dart';

final class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  @override
  Future<void> createUser(UserDto dto) async {
    try {
      await FirestoreUsersRef.doc(dto.platformUuid).set(dto);
    } catch (e) {
      // 로깅 또는 에러 핸들링
      rethrow;
    }
  }

  @override
  Future<UserDto?> fetchUser(String platformUuid) async {
    final snapshot = await FirestoreUsersRef.doc(platformUuid).get();
    return snapshot.data();
  }
}
