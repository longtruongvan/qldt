import 'package:flutter/material.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_theme.dart';

class AppTextStyle {
  static const colorPrimary = TextStyle(color: AppColors.primaryColor);

  /// S14
  static final colorPrimaryS14 = colorPrimary.copyWith(fontSize: 14);

  /// S16 Bold
  static final colorPrimaryS16 =
      colorPrimary.copyWith(fontSize: 16, fontWeight: FontWeight.w500);

  static const colorDark = TextStyle(color: AppColors.darkColor);

  /// S14 Weight 500
  static final colorDarkS14W500 = colorDark.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  /// S14 Weight bold
  static final colorDarkS14Bold = colorDark.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  /// S16 Weight 500
  static final colorDarkS16W500 = colorDark.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  /// S20 Weight 500
  static final colorDarkS20W500 = colorDark.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  /// S24
  static final colorDarkS24 = colorDark.copyWith(fontSize: 24);
  static final colorDarkS24W500 =
      colorDarkS24.copyWith(fontWeight: FontWeight.w500);

  static const colorGray = TextStyle(color: AppColors.grayColor);

  /// S14
  static final colorGrayS14 = colorGray.copyWith(fontSize: 14);
  static final colorGrayS14W400 =
      colorGrayS14.copyWith(fontWeight: FontWeight.w400);
  static final colorGrayS14W500 =
      colorGrayS14.copyWith(fontWeight: FontWeight.w500);

  /// S16 weight 500
  static final colorGrayS16W500 =
      colorGrayS14.copyWith(fontWeight: FontWeight.w500, fontSize: 16);

  /// S18 weight 500
  static final colorGrayS18W500 =
      colorGrayS14.copyWith(fontWeight: FontWeight.w500, fontSize: 18);

  static const colorDarkGray = TextStyle(color: AppColors.darkGrayColor);

  /// S14
  static final colorDarkGrayS14 = colorDarkGray.copyWith(fontSize: 14);
  static final colorDarkGrayS14W400 =
      colorDarkGrayS14.copyWith(fontWeight: FontWeight.w400);
  static final colorDarkGrayS14W500 =
      colorDarkGrayS14.copyWith(fontWeight: FontWeight.w500);

  static const colorWhite = TextStyle(color: AppColors.whiteColor);

  /// S14 Weight 500
  static final colorWhiteS14W500 = colorWhite.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  /// S16
  static final colorWhiteS16 = colorWhite.copyWith(fontSize: 16);
  static final colorWhiteS16W500 =
      colorWhiteS16.copyWith(fontWeight: FontWeight.w500);

  static const color10182B = TextStyle(color: AppColors.color10182B);

  /// S14
  static final color10182BS14 = color10182B.copyWith(fontSize: 14);
  static final color10182BS14Bold = color10182BS14.copyWith(
      fontWeight: FontWeight.bold, fontFamily: AppTheme.fontFamily);
  static final color10182BS14w400 = color10182BS14.copyWith(
      fontWeight: FontWeight.w400, fontFamily: AppTheme.fontFamily);
  static final color10182BS14w500 = color10182BS14.copyWith(
      fontWeight: FontWeight.w500, fontFamily: AppTheme.fontFamily);

  static const color3C3A36 = TextStyle(color: AppColors.color3C3A36);

  /// S14 Weight 400
  static final color3C3A36S14W400 = color3C3A36.copyWith(fontSize: 14);

  /// S16
  static final color3C3A36S16 = color3C3A36.copyWith(fontSize: 16);

  /// S14  Weight 500
  static final color3C3A36S14W500 =
  color3C3A36.copyWith(fontSize: 14, fontWeight: FontWeight.w500);


  /// S16  Weight 500
  static final color3C3A36S16W500 =
      color3C3A36.copyWith(fontSize: 16, fontWeight: FontWeight.w500);

  static final color3C3A36S18 =
  color3C3A36.copyWith(fontSize: 18);

  /// S18 Weight 500
  static final color3C3A36S18W500 =
      color3C3A36.copyWith(fontSize: 18, fontWeight: FontWeight.w500);

  /// S24
  static final color3C3A36S24 = color3C3A36.copyWith(fontSize: 24);

  /// S24 Weight 500
  static final color3C3A36S24W500 =
      color3C3A36S24.copyWith(fontWeight: FontWeight.w500);

  static const color333333 = TextStyle(color: AppColors.color333333);

  /// S32
  static final color333333S32 = color333333.copyWith(fontSize: 32);
}
