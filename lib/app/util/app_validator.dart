import 'package:flutter/material.dart';

class AppValidator {
  /// EMAIL
  static String? email(String? value) {
    if (value == null || value.isEmpty) return '이메일을 입력해주세요.';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return '이메일 형식이 올바르지 않습니다.';
    return null;
  }

  /// PASSWORD
  static String? password(String? value) {
    if (value == null || value.isEmpty) return '비밀번호를 입력해주세요.';
    if (value.length < 6) return '비밀번호는 최소 6자리 이상이어야 합니다.';
    return null;
  }

  /// TITLE: 20자 초과 시 경고
  static String? titleMax20(String? value) {
    if (value == null || value.isEmpty) return null;
    final len = value.characters.length;
    if (len > 20) return '제목은 최대 20자까지 입력할 수 있어요. ($len/20)';
    return null;
  }

  /// DESCRIPTION: 200자 초과 시 경고
  static String? descriptionMax200(String? value) {
    if (value == null || value.isEmpty) return null;
    final len = value.characters.length;
    if (len > 200) return '설명은 최대 200자까지 입력할 수 있어요. ($len/200)';
    return null;
  }
}
