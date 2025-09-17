import 'package:doit_doit/app/style/app_color.dart';
import 'package:doit_doit/app/style/app_text_style.dart';
import 'package:flutter/material.dart';

class CoolAlertDialog extends Dialog {
  const CoolAlertDialog({
    super.key,
    this.isDividedBtnFormat = false,
    this.showContentImg = true,
    this.description,
    this.subTitle,
    this.onLeftBtnClicked,
    this.leftBtnText,
    required this.btnText,
    required this.onBtnClicked,
    required this.title,
    this.customAssetPath,
  });

  factory CoolAlertDialog.singleBtn({
    required String title,
    required VoidCallback onBtnClicked,
    String? subTitle,
    String? description,
    String? btnContent,
    bool? showContentImg,
  }) =>
      CoolAlertDialog(
        title: title,
        subTitle: subTitle,
        onBtnClicked: onBtnClicked,
        description: description,
        btnText: btnContent,
        showContentImg: showContentImg,
      );

  factory CoolAlertDialog.dividedBtn({
    required String title,
    String? description,
    String? subTitle,
    bool? showContentImg,
    String? customAssetPath,
    required String leftBtnContent,
    required String rightBtnContent,
    required VoidCallback onRightBtnClicked,
    required VoidCallback onLeftBtnClicked,
  }) =>
      CoolAlertDialog(
        isDividedBtnFormat: true,
        title: title,
        subTitle: subTitle,
        onBtnClicked: onRightBtnClicked,
        onLeftBtnClicked: onLeftBtnClicked,
        description: description,
        leftBtnText: leftBtnContent,
        btnText: rightBtnContent,
        showContentImg: showContentImg,
        customAssetPath: customAssetPath,
      );

  final bool isDividedBtnFormat;
  final String title;
  final String? description;
  final VoidCallback onBtnClicked;
  final VoidCallback? onLeftBtnClicked;
  final String? btnText;
  final String? leftBtnText;
  final String? subTitle;
  final bool? showContentImg;
  final String? customAssetPath;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(minHeight: 120),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: AppColor.gray100,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(163, 163, 179, 0.07),
              blurRadius: 65,
              offset: Offset(0, 5),
            ),
            BoxShadow(
              color: Color.fromRGBO(163, 163, 179, 0.07),
              blurRadius: 20,
              offset: Offset(0, 5.86471),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /// Title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyle.bold2028.copyWith(color: AppColor.gray800),
              ),
            ),

            /// Sub Title
            if (subTitle != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  subTitle!,
                  style: AppTextStyle.med1421.copyWith(
                    color: AppColor.gray500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

            /// Description
            if (description != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8) +
                    const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  description!,
                  style: AppTextStyle.med1421.copyWith(
                    color: AppColor.gray200,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

            /// Illustration
            // if (showContentImg ?? true)
            //   Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 12),
            //     child: SvgPicture.asset(customAssetPath ?? ''
            //         //  'assets/image/small_arrow_right.svg'
            //         ),
            //   ),

            // DividedButton
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8) +
                  const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (isDividedBtnFormat)
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: onLeftBtnClicked,
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColor.gray400,
                                foregroundColor: AppColor.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 13,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                textStyle: AppTextStyle.med1421,
                              ),
                              child: Text(
                                leftBtnText!,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (isDividedBtnFormat) const SizedBox(width: 8),
                  Expanded(
                    flex: isDividedBtnFormat ? 1 : 0,
                    child: FilledButton(
                      onPressed: onBtnClicked,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColor.error400,
                        foregroundColor: AppColor.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: isDividedBtnFormat ? 16 : 32,
                          vertical: 13,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        textStyle: AppTextStyle.med1421,
                      ),
                      child: Text(
                        btnText!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
