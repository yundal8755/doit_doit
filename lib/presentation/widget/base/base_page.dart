import 'package:doit_doit/app/style/app_color.dart';
import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final PreferredSizeWidget? appbar;
  final Widget? floatingActionButton;
  final Widget? child;
  const BasePage({
    super.key,
    this.appbar,
    this.child,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      floatingActionButton: floatingActionButton,
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: child,
        ),
      ),
    );
  }
}
