import 'package:doit_doit/app/style/app_asset.dart';
import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/presentation/page/home/complete_page.dart';
import 'package:doit_doit/presentation/page/home/ongoing_page.dart';
import 'package:doit_doit/presentation/page/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    OnGoingPage(),
    CompletePage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.white,
        selectedItemColor: AppColor.primary500,
        currentIndex: _currentIndex,
        onTap: (index) {
          HapticFeedback.lightImpact();

          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 0
                  ? AppAsset.checkboxFilledIcon
                  : AppAsset.checkboxLineIcon,
            ),
            label: '할 일',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 1
                  ? AppAsset.completeFilledIcon
                  : AppAsset.completeLineIcon,
            ),
            label: '완료',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(_currentIndex == 2
                ? AppAsset.profileFilledIcon
                : AppAsset.profileLineIcon),
            label: '프로필',
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
  }
}
