import 'package:doit_doit/app/environment/app.dart';
import 'package:doit_doit/app/environment/firebase_options/firebase_options_dev.dart';
import 'package:doit_doit/app/environment/firebase_options/firebase_options_prod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    return runApp(
      const ProviderScope(
        child: App(),
      ),
    );
  }
}
