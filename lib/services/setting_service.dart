import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/helper/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingService extends GetxService {
  final RxInt currentThemeMode = 1.obs;
  final Rx<Locale> currentLocale = window.locale.obs;
  late SharedPreferences preferences;

  Future<SettingService> init() async {
    preferences = await SharedPreferences.getInstance();

    /// Theme mode
    int themeMode =
        preferences.getInt(SharedPreferencesHelper.themeModeKey) ?? 1;
    currentThemeMode.value = themeMode;
    ThemeMode theme =
        (themeMode == 1 || themeMode == 2) ? ThemeMode.light : ThemeMode.dark;
    Get.changeThemeMode(theme);

    /// Language
    String language =
        preferences.getString(SharedPreferencesHelper.languageKey) ?? 'en';
    Locale locale = Locale.fromSubtags(
      languageCode: language
    );
    currentLocale.value = locale;
    Get.updateLocale(locale);
    return this;
  }

  void changeTheme(int themeMode) async {
    preferences.setInt(SharedPreferencesHelper.themeModeKey, themeMode);
    ThemeMode theme =
        (themeMode == 1 || themeMode == 2) ? ThemeMode.light : ThemeMode.dark;
    currentThemeMode.value = themeMode;
    Get.changeThemeMode(theme);
  }

  void changeLanguage(Locale language) async {
    preferences.setString(
        SharedPreferencesHelper.languageKey, language.languageCode);
    currentLocale.value = language;
    Get.updateLocale(language);
  }
}
