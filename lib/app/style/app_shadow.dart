import 'package:flutter/material.dart';

abstract class AppShadow {
  static List<BoxShadow> elevation01dp() {
    return [
      const BoxShadow(
          color: Color(0x14000000),
          offset: Offset(0, 3),
          blurRadius: 3,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x26000000),
          offset: Offset(0, 0),
          blurRadius: 1,
          spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevation03dp() {
    return [
      const BoxShadow(
          color: Color(0x14000000),
          offset: Offset(0, 3),
          blurRadius: 8,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x08000000),
          offset: Offset(0, 2),
          blurRadius: 5,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x26000000),
          offset: Offset(0, 0),
          blurRadius: 1,
          spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevation04dp() {
    return [
      const BoxShadow(
          color: Color(0x1a000000),
          offset: Offset(0, 6),
          blurRadius: 8,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x0d000000),
          offset: Offset(0, 1),
          blurRadius: 5,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x26000000),
          offset: Offset(0, 0),
          blurRadius: 1,
          spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevation06dp() {
    return [
      const BoxShadow(
          color: Color(0x33000000),
          offset: Offset(0, 3),
          blurRadius: 5,
          spreadRadius: -1),
      const BoxShadow(
          color: Color(0x1f000000),
          offset: Offset(0, 1),
          blurRadius: 18,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x24000000),
          offset: Offset(0, 6),
          blurRadius: 10,
          spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevation8dp() {
    return [
      const BoxShadow(
          color: Color(0x33000000),
          offset: Offset(0, 3),
          blurRadius: 5,
          spreadRadius: -1),
      const BoxShadow(
          color: Color(0x1f000000),
          offset: Offset(0, 1),
          blurRadius: 18,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x24000000),
          offset: Offset(0, 6),
          blurRadius: 10,
          spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevationShadow() {
    return [
      BoxShadow(
        color: const Color(0xFFd2d2d2).withOpacity(.1),
        offset: const Offset(0, 2),
        blurRadius: 8,
      ),
    ];
  }

  static List<BoxShadow> elevationFloating() {
    return [
      BoxShadow(
        color: const Color(0xff404143).withOpacity(.06),
        offset: const Offset(0, 4),
        blurRadius: 10,
      ),
    ];
  }

  static List<BoxShadow> elevationDevices() {
    return [
      BoxShadow(
        color: const Color(0xFF403B3B).withOpacity(.05),
        offset: const Offset(0, 2),
        blurRadius: 6,
      ),
    ];
  }

  static List<BoxShadow> elevationSection() {
    return [
      BoxShadow(
        color: const Color(0xFF403B3B).withOpacity(.05),
        offset: const Offset(0, 2),
        blurRadius: 6,
      ),
    ];
  }
}
