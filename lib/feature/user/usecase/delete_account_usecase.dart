import 'package:doit_doit/app/module/error_handling/result.dart';
import 'package:doit_doit/app/util/app_log.dart';
import 'package:doit_doit/feature/auth/repository/auth_repository.dart';
import 'package:doit_doit/feature/user/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

final class DeleteAccountUseCase {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final fb.FirebaseAuth _auth;

  DeleteAccountUseCase(
    this._userRepository,
    this._authRepository, {
    fb.FirebaseAuth? auth,
  }) : _auth = auth ?? fb.FirebaseAuth.instance;

  /// 순서:
  /// 1) 파이어스토어 사용자 데이터(서브컬렉션 포함) 삭제
  /// 2) Firebase Auth 계정 삭제(재인증 필요 시 처리)
  Future<Result<void>> call() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        return Result.failure(Exception('로그인이 필요합니다.'));
      }

      // 1) 데이터 정리
      await _userRepository.deleteUser(uid);

      // 2) 계정 삭제(재인증 처리 포함)
      await _authRepository.deleteUser();

      AppLog.i('✅ 계정 삭제 완료(uid: $uid)');
      return Result.success(null);
    } on fb.FirebaseAuthException catch (e) {
      // requires-recent-login 등
      return Result.failure(e);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
