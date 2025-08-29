import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final double radius;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final BoxDecoration? decoration;

  const RoundedContainer(
      {required this.child,
      super.key,
      this.radius = 10,
      this.width,
      this.height,
      this.backgroundColor,
      this.margin,
      this.borderColor,
      this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      this.borderWidth = 1.0,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          border: borderColor != null
              ? Border.all(color: borderColor!, width: borderWidth) // 테두리 굵기 설정
              : null,
          borderRadius: BorderRadius.circular(radius)),
      child: child,
    );
  }
}
