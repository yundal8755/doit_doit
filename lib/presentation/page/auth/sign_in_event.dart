import 'package:doit_doit/app/util/app_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:naver_login_sdk/naver_login_sdk.dart';

mixin SignInEvent {
  ///
  /// 로그인 버튼 클릭시
  ///
  Future<void> onClickedNaverSignInButton({
    required WidgetRef ref,
  }) async {
    NaverLoginSDK.authenticate(
      callback: OAuthLoginCallback(
        onSuccess: () async {
          AppLog.d("Naver login success");

          // 🚀 1초 정도 지연 후 profile 조회 (SDK 가이드 권장)
          await Future.delayed(const Duration(seconds: 1));

          NaverLoginSDK.profile(
            callback: ProfileCallback(
              onSuccess: (resultCode, message, response) {
                AppLog.d(
                  "Profile fetched: resultCode=$resultCode, message=$message",
                );

                // response 는 JSON string → NaverLoginProfile 로 변환
                final profile = NaverLoginProfile.fromJson(response: response);

                AppLog.d("User id: ${profile.id}");
                AppLog.d("Email: ${profile.email}");
                AppLog.d("Name: ${profile.name}");
                AppLog.d("Nickname: ${profile.nickName}");

                // TODO: Entity/Model 로 매핑 후 상태 저장
                // final notifier = ref.read(signInOauthProvider.notifier);
                // notifier.setUser(profile);
              },
              onFailure: (httpStatus, message) {
                AppLog.w("Profile request failed: $httpStatus, $message");
              },
              onError: (errorCode, message) {
                AppLog.e("Profile error: $errorCode, $message");
              },
            ),
          );
        },
        onFailure: (httpStatus, message) {
          AppLog.w("onFailure.. httpStatus:$httpStatus, message:$message");
        },
        onError: (errorCode, message) {
          AppLog.e("onError.. errorCode:$errorCode, message:$message");
        },
      ),
    );
  }
}



    // final notifier = ref.read(signInOauthProvider.notifier);
    // await notifier.signIn(ref, SocialLoginPlatform.naver);