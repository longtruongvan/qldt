import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_text_style.dart';
import 'package:qldt/ui/widgets/textfields/app_text_field.dart';

class AppLabelTextField extends StatelessWidget {
  final String title;
  final double? spacingTitleAndTextField;
  final TextStyle? titleStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final String? hintText;
  final TextEditingController? controller;
  final Icon? iconSuffix;
  final bool? isEnable;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final Function(String text)? onChange;
  final List<TextInputFormatter>? textInputFormatter;

  const AppLabelTextField({
    Key? key,
    required this.title,
    this.spacingTitleAndTextField,
    this.titleStyle,
    this.hintStyle,
    this.hintText,
    this.controller,
    this.iconSuffix,
    this.isEnable,
    this.textStyle,
    this.textInputAction,
    this.textInputType,
    this.onChange,
    this.textInputFormatter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: titleStyle ?? AppTextStyle.color10182BS14w500,
        ),
        SizedBox(
          height: spacingTitleAndTextField ?? 5,
        ),
        AppTextField(
          hintText: hintText,
          hintStyle: hintStyle,
          controller: controller,
          suffixIcon: iconSuffix,
          isEnable: isEnable,
          textInputFormatter: textInputFormatter,
          textStyle: textStyle ?? AppTextStyle.color3C3A36S18W500,
          textInputAction: textInputAction ?? TextInputAction.done,
          keyboardType: textInputType,
          onChanged: onChange,
        ),
      ],
    );
  }
}
