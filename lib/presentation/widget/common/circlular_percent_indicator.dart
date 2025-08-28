import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:flutter/material.dart';

class CircularPercentIndicator extends StatelessWidget {
  final double percent; // 0~100

  const CircularPercentIndicator({
    super.key,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    final progress = percent.clamp(0, 100) / 100.0; // 0~1 사이 값으로 변환

    return SizedBox(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 4,
            backgroundColor: AppColor.gray200,
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColor.primary500),
          ),
          Text(
            '${percent.toInt()}%',
            style: AppTextStyle.med1421.copyWith(color: AppColor.gray900),
          ),
        ],
      ),
    );
  }
}
