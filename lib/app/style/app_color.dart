import 'package:flutter/material.dart';

abstract class AppColor {
  // Social
  static const kakao = Color(0xffFEE601);
  static const naver = Color(0xff02C75C);

  // Base
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);

  // Gray
  static const gray900 = Color(0xFF111827); // 진한 회색 (텍스트 주)
  static const gray800 = Color(0xFF374151); // 중간 진한 회색
  static const gray700 = Color(0xFF4B5563); // 회색
  static const gray600 = Color(0xFF6B7280); // 밝은 회색
  static const gray500 = Color(0xFF767676); // 회색 (세컨드 텍스트)
  static const gray400 = Color(0xFF9CA3AF); // 연한 회색
  static const gray300 = Color(0xFFE5E7EB); // 테두리/구분선
  static const gray200 = Color(0xFFF3F4F6); // 배경용
  static const gray100 = Color(0xFFF9FAFB); // 더 밝은 배경
  static const gray050 = Color(0xFFFEF2F2); // 거의 흰색 배경

  // Primary (브랜드 메인 컬러 - 파랑/보라)
  static const primary500 = Color(0xFF6366F1); // Indigo (메인)
  static const primary600 = Color(0xFF2563EB); // 파랑

  // Success (초록 계열)
  static const success500 = Color(0xFF16A34A); // 기본 성공
  static const success600 = Color(0xFF22C55E); // 강조 성공

  // Error (빨강 계열)
  static const error500 = Color(0xFFDC2626); // 경고/실패
  static const error400 = Color(0xFFEA580C); // 주황빛 경고 (alt)
}
