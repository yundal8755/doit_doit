import 'package:doit_doit/app/environment/app.dart';
import 'package:doit_doit/app/environment/firebase_options/firebase_options_dev.dart';
import 'package:doit_doit/app/environment/firebase_options/firebase_options_prod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:naver_login_sdk/naver_login_sdk.dart';

enum Flavor {
  prod,
  dev,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static Future<void> runFlavoredApp({required Flavor flavor}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();

    // Firebase 초기화
    await Firebase.initializeApp(
      options: flavor == Flavor.prod
          ? ProdFirebaseOptions.currentPlatform
          : DevFirebaseOptions.currentPlatform,
    );

    await dotenv.load(fileName: ".env");

    // 카카오 로그인
    final kakaoKey = dotenv.env['kakao_login_key'];
    if (kakaoKey == null || kakaoKey.isEmpty) {
      throw Exception("KAKAO_LOGIN_KEY is missing in .env");
    }
    KakaoSdk.init(nativeAppKey: kakaoKey);

    // 네이버 로그인
    await NaverLoginSDK.initialize(
      urlScheme: dotenv.env['naver_url_scheme'],
      clientId: dotenv.env['naver_client_id']!,
      clientSecret: dotenv.env['naver_client_secret']!,
      clientName: dotenv.env['naver_client_name']!,
    );

    // RUN APP
    return runApp(
      const ProviderScope(
        child: App(),
      ),
    );
  }
}
