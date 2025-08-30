// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userInfoHash() => r'ce6ddf3f1d04f0bf0164ef72fe50adc8f22ac337';

///
/// 현재 유저의 정보를 UserEntity 형태로 전달하는 Provider
///
///
/// Copied from [UserInfo].
@ProviderFor(UserInfo)
final userInfoProvider =
    AutoDisposeAsyncNotifierProvider<UserInfo, UserEntity?>.internal(
  UserInfo.new,
  name: r'userInfoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserInfo = AutoDisposeAsyncNotifier<UserEntity?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
