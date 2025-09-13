import 'package:doit_doit/app/style/app_color.dart';
import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final PreferredSizeWidget? appbar;
  final Widget? floatingActionButton;
  final Widget? child;
  final bool resizeToAvoidBottomInset;
  const BasePage({
    super.key,
    this.appbar,
    this.child,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: child,
        ),
      ),
    );
  }
}
