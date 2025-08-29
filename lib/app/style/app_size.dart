import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppSize {
  // 📱 화면 기준 사이즈
  static const horizontalMode = Size(812, 375);
  static const verticalMode = Size(375, 812);
  static const tabletVerticalSize = Size(700, 1232);

  // 🔲 Radius
  static double get cornerSmall => 5.r;
  static double get cornerMedium => 10.r;
  static double get cornerLarge => 50.r;

  // 🔘 버튼
  static double get loginButtonWidth => 400.w;
  static double get loginButtonHeight => 50.h;
  static double get buttonWidth => 284.w;
  static double get buttonHeight => 50.h;
  static double get buttonRadius => 5.r;

  // ✏️ 텍스트 필드
  static double get textFieldWidth => 400.w;
  static double get textFieldHeight => 48.h;

  // 📏 Vertical spacing
  static double get spaceXS => 8.h;
  static double get spaceS => 16.h;
  static double get spaceM => 24.h;
  static double get spaceL => 30.h;
  static double get spaceXL => 36.h;
  static double get spaceXXL => 42.h;

  // 📐 Horizontal spacing
  static double get gapXS => 8.w;
  static double get gapS => 16.w;
  static double get gapM => 24.w;
  static double get gapL => 30.w;
  static double get gapXL => 36.w;

  // 📦 컨테이너
  static double get loginBoxWidth => 460.w;
  static double get loginBoxHeight => 550.h;
  static double get signupBoxWidth => 460.w;
  static double get signupBoxHeight => 610.h;

  // 🖼️ 이미지/아이콘
  static double get logoHeight => 100.h;
  static double get logoWidth => 190.w;
  static double get therapyStartIconWidth => 160.w;
  static double get therapyStartIconHeight => 152.h;
  static double get therapyHistoryIconWidth => 136.31.w;
  static double get therapyHistoryIconHeight => 130.h;
  static double get iconSize => 40.r;
  static double get mainAppIconSize => 40.r;
  static double get iconBoxSize => 60.r;

  // 🔤 폰트
  static double get fontSmall => 12.sp;
  static double get fontMedium => 14.sp;
  static double get fontLarge => 16.sp;
  static double get fontXL => 18.sp;
  static double get fontXXL => 26.sp;
  static double get fontXXXL => 38.sp;

  // 📊 상태바 높이
  static double statusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }
}
