import 'package:flutter/material.dart';

abstract class AppTextStyle {
  static TextStyle pretendardStyle(double size, double? height) => TextStyle(
        fontFamily: 'pretendard',
        leadingDistribution: TextLeadingDistribution.even,
        letterSpacing: -2 / 100 * size,
        fontSize: size,
        height: height == null ? null : height / size,
      );

  static TextStyle pretendardMediumStyle(double size, double? height) =>
      pretendardStyle(size, height).copyWith(
        fontWeight: FontWeight.w500,
      );

  static TextStyle pretendardSemiBoldStyle(double size, double? height) =>
      pretendardStyle(size, height).copyWith(
        fontWeight: FontWeight.w600,
      );

  static TextStyle pretendardBoldStyle(double size, double? height) =>
      pretendardStyle(size, height).copyWith(
        fontWeight: FontWeight.w700,
      );

  // bold
  static final TextStyle bold2028 = pretendardBoldStyle(20, 28);

  // semi-bold
  static final TextStyle semi1828 = pretendardSemiBoldStyle(18, 28);
  static final TextStyle semi1421 = pretendardSemiBoldStyle(14, 21);

  // medium
  static final TextStyle med1421 = pretendardMediumStyle(14, 21);
  static final TextStyle med1216 = pretendardMediumStyle(12, 16);
}
