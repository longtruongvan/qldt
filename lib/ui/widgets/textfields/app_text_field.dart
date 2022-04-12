import 'package:flutter/material.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_dimens.dart';
import 'package:qldt/common/app_text_style.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Color? enableBorderColor;
  final Color? focusBorderColor;
  final Color? cursorColor;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;

  /// properties text input password
  final bool? obscureText;
  final bool? enableSuggestions;
  final bool? autoCorrect;
  final String? obscuringCharacter;

  const AppTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.enableBorderColor,
    this.focusBorderColor,
    this.cursorColor,
    this.hintStyle,
    this.borderRadius,
    this.contentPadding,
    this.keyboardType,
    this.textStyle,
    this.autoCorrect,
    this.enableSuggestions,
    this.obscureText,
    this.obscuringCharacter,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: cursorColor,
      keyboardType: keyboardType ?? TextInputType.text,
      style: textStyle ?? AppTextStyle.color10182BS14w500,
      autocorrect: autoCorrect ?? true,
      enableSuggestions: enableSuggestions ?? true,
      obscureText: obscureText ?? false,
      // obscuringCharacter: obscuringCharacter ?? '',
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ?? AppTextStyle.colorDarkGrayS14W400,
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(borderRadius ?? AppDimens.borderNormal),
          borderSide: BorderSide(
            color: enableBorderColor ?? AppColors.grayColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(borderRadius ?? AppDimens.borderNormal),
          borderSide: BorderSide(
            color: focusBorderColor ?? AppColors.grayColor,
          ),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
