import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_dimens.dart';
import 'package:qldt/common/app_text_style.dart';

class AppButton extends StatelessWidget {
  final String? title;
  final TextStyle? textStyle;
  final VoidCallback? onPress;

  const AppButton({
    Key? key,
    this.title,
    this.textStyle,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (onPress == null) {
          return;
        }
        onPress!();
        // TO DO
      },
      child: Container(
        width: Get.size.width,
        alignment: Alignment.center,
        child: Text(
          title ?? '',
          style: textStyle ?? AppTextStyle.colorWhiteS16W500,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: AppColors.primaryColor,
        padding: const EdgeInsets.all(AppDimens.spacingNormal),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.spacingNormal),
        ),
      ),
    );
  }
}
