import 'package:doit_doit/pages/root_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ko')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.blue), home: const RootPage()),
    );
  }
}
