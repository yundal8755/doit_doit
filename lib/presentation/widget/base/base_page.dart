import 'package:doit_doit/app/style/app_asset.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/presentation/component/button/base_button.dart';
import 'package:doit_doit/presentation/widget/common/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BasePage extends StatelessWidget {
  final Widget? bottomNavBar;
  final PreferredSizeWidget? appbar;
  final Widget? child;
  const BasePage({super.key, this.appbar, this.child, this.bottomNavBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavBar,
      floatingActionButton: BaseButton(
        child: RoundedContainer(
          backgroundColor: AppColor.primary600,
          padding: const EdgeInsets.all(16),
          child: SvgPicture.asset(AppAsset.plusIcon),
        ),
      ),
      backgroundColor: AppColor.white,
      appBar: appbar,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: child,
        ),
      ),
    );
  }
}
