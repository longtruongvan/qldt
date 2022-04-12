import 'package:flutter/material.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_theme.dart';

class AppTextStyle {
  static const colorGray = TextStyle(color: AppColors.grayColor);
  /// S14
  static final colorGrayS14 = colorGray.copyWith(fontSize: 14);
  static final colorGrayS14W400 = colorGrayS14.copyWith(fontWeight: FontWeight.w400);
  static final colorGrayS14W500 = colorGrayS14.copyWith(fontWeight: FontWeight.w500);


  static const colorDarkGray = TextStyle(color: AppColors.darkGrayColor);
  /// S14
  static final colorDarkGrayS14 = colorDarkGray.copyWith(fontSize: 14);
  static final colorDarkGrayS14W400 = colorDarkGrayS14.copyWith(fontWeight: FontWeight.w400);
  static final colorDarkGrayS14W500 = colorDarkGrayS14.copyWith(fontWeight: FontWeight.w500);


  static const colorWhite = TextStyle(color: AppColors.whiteColor);
  /// S16
  static final colorWhiteS16=colorWhite.copyWith(fontSize: 16);
  static final colorWhiteS16W500=colorWhiteS16.copyWith(fontWeight: FontWeight.w500);

  static const color10182B = TextStyle(color: AppColors.color10182B);
  /// S14
  static final color10182BS14 = color10182B.copyWith(fontSize: 14);
  static final color10182BS14Bold = color10182BS14.copyWith(
      fontWeight: FontWeight.bold, fontFamily: AppTheme.fontFamily);
  static final color10182BS14w400 = color10182BS14.copyWith(
      fontWeight: FontWeight.w400, fontFamily: AppTheme.fontFamily);
  static final color10182BS14w500 = color10182BS14.copyWith(
      fontWeight: FontWeight.w500, fontFamily: AppTheme.fontFamily);
}
