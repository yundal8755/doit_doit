import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

///
/// 공통 로직을 담당하는 베이스 위젯
///
class BaseButton extends StatefulWidget {
  final Widget child;
  final Function? onPressed;

  // 선택
  final VoidCallback? onLongPress;
  final String? title;
  final String? icon;
  final String? leadingIcon;
  final String? trailingIcon;
  final bool bounceable;
  final bool useHapticFeedback;
  final bool useLongPress;
  final double? width;
  final double? height;

  const BaseButton({
    super.key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.title,
    this.icon,
    this.leadingIcon,
    this.trailingIcon,
    this.bounceable = true,
    this.useHapticFeedback = false,
    this.useLongPress = false,
    this.width,
    this.height,
  });

  @override
  State<BaseButton> createState() => _BaseButtonState();
}

class _BaseButtonState extends State<BaseButton> {
  @override
  Widget build(BuildContext context) {
    bool enabled = widget.onPressed != null;

    if (widget.bounceable) {
      return Bounceable(
        onTap: enabled ? _handleTap : null,
        onLongPress: widget.useLongPress && enabled ? widget.onLongPress : null,
        child: widget.child,
      );
    } else {
      return GestureDetector(
        onTap: enabled ? _handleTap : null,
        onLongPress: widget.useLongPress && enabled ? widget.onLongPress : null,
        child: widget.child,
      );
    }
  }

  void _handleTap() {
    if (widget.useHapticFeedback) {
      HapticFeedback.lightImpact();
    }
    widget.onPressed?.call();
  }
}
