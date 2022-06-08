// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message(
      'System',
      name: 'system',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Vietnamese`
  String get vietnamese {
    return Intl.message(
      'Vietnamese',
      name: 'vietnamese',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get common_warning {
    return Intl.message(
      'Warning',
      name: 'common_warning',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the correct phone number`
  String get update_profile_check_phone {
    return Intl.message(
      'Please enter the correct phone number',
      name: 'update_profile_check_phone',
      desc: '',
      args: [],
    );
  }

  /// `Add location`
  String get common_add_location {
    return Intl.message(
      'Add location',
      name: 'common_add_location',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get common_save {
    return Intl.message(
      'Save',
      name: 'common_save',
      desc: '',
      args: [],
    );
  }

  /// `Select class`
  String get common_select_class {
    return Intl.message(
      'Select class',
      name: 'common_select_class',
      desc: '',
      args: [],
    );
  }

  /// `Enter the number of students`
  String get create_user_input_number_student {
    return Intl.message(
      'Enter the number of students',
      name: 'create_user_input_number_student',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get common_error {
    return Intl.message(
      'Error',
      name: 'common_error',
      desc: '',
      args: [],
    );
  }

  /// `Fetch data failure`
  String get common_fetch_data_failure {
    return Intl.message(
      'Fetch data failure',
      name: 'common_fetch_data_failure',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get common_next {
    return Intl.message(
      'Next',
      name: 'common_next',
      desc: '',
      args: [],
    );
  }

  /// `Please enter enough information`
  String get common_enter_enough_information {
    return Intl.message(
      'Please enter enough information',
      name: 'common_enter_enough_information',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get common_success {
    return Intl.message(
      'Success',
      name: 'common_success',
      desc: '',
      args: [],
    );
  }

  /// `Create user success`
  String get create_user_state_success {
    return Intl.message(
      'Create user success',
      name: 'create_user_state_success',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get common_ok {
    return Intl.message(
      'OK',
      name: 'common_ok',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get common_subject {
    return Intl.message(
      'Subject',
      name: 'common_subject',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get common_code {
    return Intl.message(
      'Code',
      name: 'common_code',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Add phone number`
  String get edit_profile_add_phone_number {
    return Intl.message(
      'Add phone number',
      name: 'edit_profile_add_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Add location`
  String get edit_profile_add_location {
    return Intl.message(
      'Add location',
      name: 'edit_profile_add_location',
      desc: '',
      args: [],
    );
  }

  /// `Update information`
  String get edit_profile_update_infomation {
    return Intl.message(
      'Update information',
      name: 'edit_profile_update_infomation',
      desc: '',
      args: [],
    );
  }

  /// `Send to me`
  String get common_send_to_me {
    return Intl.message(
      'Send to me',
      name: 'common_send_to_me',
      desc: '',
      args: [],
    );
  }

  /// `Student registration`
  String get home_student_register {
    return Intl.message(
      'Student registration',
      name: 'home_student_register',
      desc: '',
      args: [],
    );
  }

  /// `Hello,`
  String get common_hello {
    return Intl.message(
      'Hello,',
      name: 'common_hello',
      desc: '',
      args: [],
    );
  }

  /// `Select day`
  String get create_time_table_select_day {
    return Intl.message(
      'Select day',
      name: 'create_time_table_select_day',
      desc: '',
      args: [],
    );
  }

  /// `Select lesson`
  String get create_time_table_select_lesson {
    return Intl.message(
      'Select lesson',
      name: 'create_time_table_select_lesson',
      desc: '',
      args: [],
    );
  }

  /// `Please select a calendar`
  String get create_time_table_please_select_calendar {
    return Intl.message(
      'Please select a calendar',
      name: 'create_time_table_please_select_calendar',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
