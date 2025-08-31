import 'package:doit_doit/app/di/user_di.dart';
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/feature/user/dto/user_dto.dart';
import 'package:doit_doit/feature/user/entity/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
class User extends _$User {
  @override
  FutureOr<UserEntity?> build() async {
    // 앱 시작 시 현재 로그인한 유저 fetch
    final String platformUuid = FirebaseAuth.instance.currentUser?.uid ?? "";
    try {
      final entity =
          await ref.read(fetchUserInfoUsecaseProvider).call(platformUuid);
      return entity;
    } catch (e, st) {
      AppLog.e(e);
      state = AsyncError(e, st);
      return null;
    }
  }

  ///
  /// 회원가입
  ///
  Future<void> createUser(WidgetRef ref, UserDto dto) async {
    try {
      // 1. createUser 보내고 예외/분기처리
      ref.read(createUserUsecaseProvider).call(dto);
      // 2. fetchUser 전달받고 예외/분기처리
    } catch (e) {
      AppLog.e(e);
    }
  }

  ///
  /// 유저 정보 불러오기
  ///
  Future<UserEntity?> fetchUser(WidgetRef ref, String platformUuid) async {
    final usecase = ref.watch(fetchUserInfoUsecaseProvider).call(platformUuid);
    return usecase;
  }
}
