import 'package:doit_doit/feature/auth/entity/user_entity.dart';
import 'package:doit_doit/presentation/provider/user/user_info_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin ProfileState {
  ///
  /// 유저 엔티티 정보
  ///
  AsyncValue<UserEntity?> userAsync(WidgetRef ref) =>
      ref.watch(userInfoProvider);
}
