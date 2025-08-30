import 'package:doit_doit/app/di/auth_di.dart';
import 'package:doit_doit/feature/auth/entity/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_info_provider.g.dart';

///
/// 현재 유저의 정보를 UserEntity 형태로 전달하는 Provider
///
@riverpod
class UserInfo extends _$UserInfo {
  @override
  Future<UserEntity?> build() async {
    return ref.watch(getCurrentUserInfoUseCaseProvider).call();
  }
}
