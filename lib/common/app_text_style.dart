import 'package:flutter/material.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_theme.dart';

class AppTextStyle {
  static const color10182B = TextStyle(color: AppColors.color10182B);

  /// S56
  static final color10182BS56 = color10182B.copyWith(fontSize: 56);
  static final color10182BS56Bold = color10182BS56.copyWith(
      fontWeight: FontWeight.bold, fontFamily: AppTheme.fontFamily);
  static final color10182BS56w500 = color10182BS56.copyWith(
      fontWeight: FontWeight.w500, fontFamily: AppTheme.fontFamily);
}
