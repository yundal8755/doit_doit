import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/app/module/error_handling/result.dart';
import 'package:doit_doit/app/di/user_di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_account_provider.g.dart';

@riverpod
class DeleteAccount extends _$DeleteAccount {
  @override
  Future<void> build() async {}

  Future<Result<void>> delete() async {
    state = const AsyncLoading();

    final usecase = ref.read(deleteUserUsecaseProvider);
    final result = await usecase.call();

    result.fold(
      onSuccess: (_) {
        state = const AsyncData(null);
      },
      onFailure: (e) {
        AppLog.e('계정 삭제 실패: $e');
        state = AsyncError(e, StackTrace.current);
      },
    );

    return result;
  }
}
