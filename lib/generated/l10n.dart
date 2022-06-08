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

  /// `Notification`
  String get common_notification {
    return Intl.message(
      'Notification',
      name: 'common_notification',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to pay tuition fees for this semester?. Please confirm`
  String get pay_tuition {
    return Intl.message(
      'Do you want to pay tuition fees for this semester?. Please confirm',
      name: 'pay_tuition',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get common_cancel {
    return Intl.message(
      'Cancel',
      name: 'common_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get tuition_payment {
    return Intl.message(
      'Payment',
      name: 'tuition_payment',
      desc: '',
      args: [],
    );
  }

  /// `Tuition:`
  String get tuition {
    return Intl.message(
      'Tuition:',
      name: 'tuition',
      desc: '',
      args: [],
    );
  }

  /// `Status:`
  String get common_status {
    return Intl.message(
      'Status:',
      name: 'common_status',
      desc: '',
      args: [],
    );
  }

  /// `Method:`
  String get tuition_method {
    return Intl.message(
      'Method:',
      name: 'tuition_method',
      desc: '',
      args: [],
    );
  }

  /// `Detail tuition`
  String get detail_tuition {
    return Intl.message(
      'Detail tuition',
      name: 'detail_tuition',
      desc: '',
      args: [],
    );
  }

  /// `Time:`
  String get common_time {
    return Intl.message(
      'Time:',
      name: 'common_time',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get common_home {
    return Intl.message(
      'Home',
      name: 'common_home',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get common_calendar {
    return Intl.message(
      'Calendar',
      name: 'common_calendar',
      desc: '',
      args: [],
    );
  }

  /// `Alert`
  String get common_alert {
    return Intl.message(
      'Alert',
      name: 'common_alert',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get common_profile {
    return Intl.message(
      'Profile',
      name: 'common_profile',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get common_setting {
    return Intl.message(
      'Setting',
      name: 'common_setting',
      desc: '',
      args: [],
    );
  }

  /// `Score`
  String get common_score {
    return Intl.message(
      'Score',
      name: 'common_score',
      desc: '',
      args: [],
    );
  }

  /// `Course`
  String get common_course {
    return Intl.message(
      'Course',
      name: 'common_course',
      desc: '',
      args: [],
    );
  }

  /// `Exam schedule`
  String get common_exam_schedule {
    return Intl.message(
      'Exam schedule',
      name: 'common_exam_schedule',
      desc: '',
      args: [],
    );
  }

  /// `Select Specialized`
  String get common_select_specialized {
    return Intl.message(
      'Select Specialized',
      name: 'common_select_specialized',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get common_no_data {
    return Intl.message(
      'No data',
      name: 'common_no_data',
      desc: '',
      args: [],
    );
  }

  /// `Select student`
  String get common_select_student {
    return Intl.message(
      'Select student',
      name: 'common_select_student',
      desc: '',
      args: [],
    );
  }

  /// `Select subject`
  String get common_select_subject {
    return Intl.message(
      'Select subject',
      name: 'common_select_subject',
      desc: '',
      args: [],
    );
  }

  /// `Score manager`
  String get score_manager {
    return Intl.message(
      'Score manager',
      name: 'score_manager',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get common_clear {
    return Intl.message(
      'Clear',
      name: 'common_clear',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get common_all {
    return Intl.message(
      'All',
      name: 'common_all',
      desc: '',
      args: [],
    );
  }

  /// `Name course`
  String get course_name_course {
    return Intl.message(
      'Name course',
      name: 'course_name_course',
      desc: '',
      args: [],
    );
  }

  /// `Specialized`
  String get specialized {
    return Intl.message(
      'Specialized',
      name: 'specialized',
      desc: '',
      args: [],
    );
  }

  /// `Time payment`
  String get course_time_payment {
    return Intl.message(
      'Time payment',
      name: 'course_time_payment',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get common_unknown {
    return Intl.message(
      'Unknown',
      name: 'common_unknown',
      desc: '',
      args: [],
    );
  }

  /// `Period`
  String get course_period {
    return Intl.message(
      'Period',
      name: 'course_period',
      desc: '',
      args: [],
    );
  }

  /// `Number of period`
  String get course_number_of_period {
    return Intl.message(
      'Number of period',
      name: 'course_number_of_period',
      desc: '',
      args: [],
    );
  }

  /// `Detail course`
  String get course_detail_course {
    return Intl.message(
      'Detail course',
      name: 'course_detail_course',
      desc: '',
      args: [],
    );
  }

  /// `Courses`
  String get courses {
    return Intl.message(
      'Courses',
      name: 'courses',
      desc: '',
      args: [],
    );
  }

  /// `Register subject`
  String get register_subject {
    return Intl.message(
      'Register subject',
      name: 'register_subject',
      desc: '',
      args: [],
    );
  }

  /// `Please select a subject`
  String get pleaseSelectASubject {
    return Intl.message(
      'Please select a subject',
      name: 'pleaseSelectASubject',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the enough information`
  String get pleaseEnterTheEnoughInformation {
    return Intl.message(
      'Please enter the enough information',
      name: 'pleaseEnterTheEnoughInformation',
      desc: '',
      args: [],
    );
  }

  /// `Please select the time learning`
  String get pleaseSelectTheTimeLearning {
    return Intl.message(
      'Please select the time learning',
      name: 'pleaseSelectTheTimeLearning',
      desc: '',
      args: [],
    );
  }

  /// `List Subject`
  String get list_subject {
    return Intl.message(
      'List Subject',
      name: 'list_subject',
      desc: '',
      args: [],
    );
  }

  /// `Name subject`
  String get common_name_subject {
    return Intl.message(
      'Name subject',
      name: 'common_name_subject',
      desc: '',
      args: [],
    );
  }

  /// `Number of period`
  String get numberOfPeriod {
    return Intl.message(
      'Number of period',
      name: 'numberOfPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Period start`
  String get periodStart {
    return Intl.message(
      'Period start',
      name: 'periodStart',
      desc: '',
      args: [],
    );
  }

  /// `Register subject`
  String get registerSubject {
    return Intl.message(
      'Register subject',
      name: 'registerSubject',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any class today 😅`
  String get youDontHaveAnyClassToday {
    return Intl.message(
      'You don\'t have any class today 😅',
      name: 'youDontHaveAnyClassToday',
      desc: '',
      args: [],
    );
  }

  /// `Create user`
  String get createUser {
    return Intl.message(
      'Create user',
      name: 'createUser',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get common_search {
    return Intl.message(
      'Search',
      name: 'common_search',
      desc: '',
      args: [],
    );
  }

  /// `User manager`
  String get userManager {
    return Intl.message(
      'User manager',
      name: 'userManager',
      desc: '',
      args: [],
    );
  }

  /// `You have not provided enough information. Please check again`
  String get youHaveNotProvidedEnoughInformationPleaseCheckAgain {
    return Intl.message(
      'You have not provided enough information. Please check again',
      name: 'youHaveNotProvidedEnoughInformationPleaseCheckAgain',
      desc: '',
      args: [],
    );
  }

  /// `Add specialized success`
  String get addSpecializedSuccess {
    return Intl.message(
      'Add specialized success',
      name: 'addSpecializedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `input code`
  String get inputCode {
    return Intl.message(
      'input code',
      name: 'inputCode',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `input name`
  String get inputName {
    return Intl.message(
      'input name',
      name: 'inputName',
      desc: '',
      args: [],
    );
  }

  /// `Display name`
  String get displayName {
    return Intl.message(
      'Display name',
      name: 'displayName',
      desc: '',
      args: [],
    );
  }

  /// `input display name`
  String get inputDisplayName {
    return Intl.message(
      'input display name',
      name: 'inputDisplayName',
      desc: '',
      args: [],
    );
  }

  /// `Add specialized`
  String get addSpecialized {
    return Intl.message(
      'Add specialized',
      name: 'addSpecialized',
      desc: '',
      args: [],
    );
  }

  /// `Delete specialized success`
  String get deleteSpecializedSuccess {
    return Intl.message(
      'Delete specialized success',
      name: 'deleteSpecializedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Delete specialized failure`
  String get deleteSpecializedFailure {
    return Intl.message(
      'Delete specialized failure',
      name: 'deleteSpecializedFailure',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete specialized. Please confirm`
  String get doYouWantToDeleteSpecializedPleaseConfirm {
    return Intl.message(
      'Do you want to delete specialized. Please confirm',
      name: 'doYouWantToDeleteSpecializedPleaseConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Update specialized success`
  String get updateSpecializedSuccess {
    return Intl.message(
      'Update specialized success',
      name: 'updateSpecializedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Update specialized`
  String get updateSpecialized {
    return Intl.message(
      'Update specialized',
      name: 'updateSpecialized',
      desc: '',
      args: [],
    );
  }

  /// `Add subject success`
  String get addSubjectSuccess {
    return Intl.message(
      'Add subject success',
      name: 'addSubjectSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Add subject failure`
  String get addSubjectFailure {
    return Intl.message(
      'Add subject failure',
      name: 'addSubjectFailure',
      desc: '',
      args: [],
    );
  }

  /// `Code subject`
  String get add_subject_code_subject {
    return Intl.message(
      'Code subject',
      name: 'add_subject_code_subject',
      desc: '',
      args: [],
    );
  }

  /// `Number of lesson`
  String get add_subject_numberOfLesson {
    return Intl.message(
      'Number of lesson',
      name: 'add_subject_numberOfLesson',
      desc: '',
      args: [],
    );
  }

  /// `Add Subjects`
  String get addSubjects {
    return Intl.message(
      'Add Subjects',
      name: 'addSubjects',
      desc: '',
      args: [],
    );
  }

  /// `Update subject success`
  String get updateSubjectSuccess {
    return Intl.message(
      'Update subject success',
      name: 'updateSubjectSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Update subject failure`
  String get updateSubjectFailure {
    return Intl.message(
      'Update subject failure',
      name: 'updateSubjectFailure',
      desc: '',
      args: [],
    );
  }

  /// `Delete subject success`
  String get deleteSubjectSuccess {
    return Intl.message(
      'Delete subject success',
      name: 'deleteSubjectSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Delete subject failure`
  String get deleteSubjectFailure {
    return Intl.message(
      'Delete subject failure',
      name: 'deleteSubjectFailure',
      desc: '',
      args: [],
    );
  }

  /// `Subjects`
  String get subjects {
    return Intl.message(
      'Subjects',
      name: 'subjects',
      desc: '',
      args: [],
    );
  }

  /// `You have not provided enough information`
  String get youHaveNotProvidedEnoughInformation {
    return Intl.message(
      'You have not provided enough information',
      name: 'youHaveNotProvidedEnoughInformation',
      desc: '',
      args: [],
    );
  }

  /// `Add department success`
  String get addDepartmentSuccess {
    return Intl.message(
      'Add department success',
      name: 'addDepartmentSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Add department failure`
  String get addDepartmentFailure {
    return Intl.message(
      'Add department failure',
      name: 'addDepartmentFailure',
      desc: '',
      args: [],
    );
  }

  /// `Select building`
  String get common_select_building {
    return Intl.message(
      'Select building',
      name: 'common_select_building',
      desc: '',
      args: [],
    );
  }

  /// `Update department`
  String get updateDepartment {
    return Intl.message(
      'Update department',
      name: 'updateDepartment',
      desc: '',
      args: [],
    );
  }

  /// `Name department`
  String get nameDepartment {
    return Intl.message(
      'Name department',
      name: 'nameDepartment',
      desc: '',
      args: [],
    );
  }

  /// `Location department`
  String get locationDepartment {
    return Intl.message(
      'Location department',
      name: 'locationDepartment',
      desc: '',
      args: [],
    );
  }

  /// `Description department`
  String get descriptionDepartment {
    return Intl.message(
      'Description department',
      name: 'descriptionDepartment',
      desc: '',
      args: [],
    );
  }

  /// `Delete department success`
  String get deleteDepartmentSuccess {
    return Intl.message(
      'Delete department success',
      name: 'deleteDepartmentSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Delete department failure`
  String get deleteDepartmentFailure {
    return Intl.message(
      'Delete department failure',
      name: 'deleteDepartmentFailure',
      desc: '',
      args: [],
    );
  }

  /// `Book class room success`
  String get bookClassRoomSuccess {
    return Intl.message(
      'Book class room success',
      name: 'bookClassRoomSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Book class room failure`
  String get bookClassRoomFailure {
    return Intl.message(
      'Book class room failure',
      name: 'bookClassRoomFailure',
      desc: '',
      args: [],
    );
  }

  /// `Building`
  String get update_department_building {
    return Intl.message(
      'Building',
      name: 'update_department_building',
      desc: '',
      args: [],
    );
  }

  /// `Location:`
  String get update_department_location {
    return Intl.message(
      'Location:',
      name: 'update_department_location',
      desc: '',
      args: [],
    );
  }

  /// `Description:`
  String get update_department_description {
    return Intl.message(
      'Description:',
      name: 'update_department_description',
      desc: '',
      args: [],
    );
  }

  /// `You can't book this room, because someone already booked`
  String get youCantBookThisRoomBecauseSomeoneAlreadyBooked {
    return Intl.message(
      'You can\'t book this room, because someone already booked',
      name: 'youCantBookThisRoomBecauseSomeoneAlreadyBooked',
      desc: '',
      args: [],
    );
  }

  /// `Book now`
  String get bookNow {
    return Intl.message(
      'Book now',
      name: 'bookNow',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this department? Please confirm.`
  String get doYouWantToDeleteThisDepartmentPleaseConfirm {
    return Intl.message(
      'Do you want to delete this department? Please confirm.',
      name: 'doYouWantToDeleteThisDepartmentPleaseConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Department name`
  String get departmentName {
    return Intl.message(
      'Department name',
      name: 'departmentName',
      desc: '',
      args: [],
    );
  }

  /// `Time order:`
  String get timeOrder {
    return Intl.message(
      'Time order:',
      name: 'timeOrder',
      desc: '',
      args: [],
    );
  }

  /// `Order by`
  String get orderBy {
    return Intl.message(
      'Order by',
      name: 'orderBy',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Search department`
  String get searchDepartment {
    return Intl.message(
      'Search department',
      name: 'searchDepartment',
      desc: '',
      args: [],
    );
  }

  /// `Update department success`
  String get updateDepartmentSuccess {
    return Intl.message(
      'Update department success',
      name: 'updateDepartmentSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Update department failure`
  String get updateDepartmentFailure {
    return Intl.message(
      'Update department failure',
      name: 'updateDepartmentFailure',
      desc: '',
      args: [],
    );
  }

  /// `List of departments`
  String get listOfDepartments {
    return Intl.message(
      'List of departments',
      name: 'listOfDepartments',
      desc: '',
      args: [],
    );
  }

  /// `Department manager`
  String get departmentManager {
    return Intl.message(
      'Department manager',
      name: 'departmentManager',
      desc: '',
      args: [],
    );
  }

  /// `Subject Manager`
  String get subjectManager {
    return Intl.message(
      'Subject Manager',
      name: 'subjectManager',
      desc: '',
      args: [],
    );
  }

  /// `Add, edit, delete, search, set subject, ...`
  String get addEditDeleteSearchSetSubject {
    return Intl.message(
      'Add, edit, delete, search, set subject, ...',
      name: 'addEditDeleteSearchSetSubject',
      desc: '',
      args: [],
    );
  }

  /// `Specialized Manager`
  String get system_mn_specializedManager {
    return Intl.message(
      'Specialized Manager',
      name: 'system_mn_specializedManager',
      desc: '',
      args: [],
    );
  }

  /// `Add, edit, delete, search, set specialized, ...`
  String get addEditDeleteSearchSetSpecialized {
    return Intl.message(
      'Add, edit, delete, search, set specialized, ...',
      name: 'addEditDeleteSearchSetSpecialized',
      desc: '',
      args: [],
    );
  }

  /// `Add, edit, delete, search, set departments, ...`
  String get addEditDeleteSearchSetDepartments {
    return Intl.message(
      'Add, edit, delete, search, set departments, ...',
      name: 'addEditDeleteSearchSetDepartments',
      desc: '',
      args: [],
    );
  }

  /// `You can add or level permissions for user, ...`
  String get youCanAddOrLevelPermissionsForUser {
    return Intl.message(
      'You can add or level permissions for user, ...',
      name: 'youCanAddOrLevelPermissionsForUser',
      desc: '',
      args: [],
    );
  }

  /// `You have not filled in enough information`
  String get youHaveNotFilledInEnoughInformation {
    return Intl.message(
      'You have not filled in enough information',
      name: 'youHaveNotFilledInEnoughInformation',
      desc: '',
      args: [],
    );
  }

  /// `Create exam schedule success`
  String get createExamScheduleSuccess {
    return Intl.message(
      'Create exam schedule success',
      name: 'createExamScheduleSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Create exam schedule failure`
  String get createExamScheduleFailure {
    return Intl.message(
      'Create exam schedule failure',
      name: 'createExamScheduleFailure',
      desc: '',
      args: [],
    );
  }

  /// `Get info subject failure`
  String get getInfoSubjectFailure {
    return Intl.message(
      'Get info subject failure',
      name: 'getInfoSubjectFailure',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get detail_exam_title {
    return Intl.message(
      'Title',
      name: 'detail_exam_title',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get detail_exam_subject {
    return Intl.message(
      'Subject',
      name: 'detail_exam_subject',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get detail_exam_time {
    return Intl.message(
      'Time',
      name: 'detail_exam_time',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get detail_exam_day {
    return Intl.message(
      'Day',
      name: 'detail_exam_day',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get detail_exam_description {
    return Intl.message(
      'Description',
      name: 'detail_exam_description',
      desc: '',
      args: [],
    );
  }

  /// `Detail exam schedule`
  String get detailExamSchedule {
    return Intl.message(
      'Detail exam schedule',
      name: 'detailExamSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Exam schedules`
  String get examSchedules {
    return Intl.message(
      'Exam schedules',
      name: 'examSchedules',
      desc: '',
      args: [],
    );
  }

  /// `Create exam schedule`
  String get createExamSchedule {
    return Intl.message(
      'Create exam schedule',
      name: 'createExamSchedule',
      desc: '',
      args: [],
    );
  }

  /// `List of exam schedule`
  String get listOfExamSchedule {
    return Intl.message(
      'List of exam schedule',
      name: 'listOfExamSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Exam schedule`
  String get examSchedule_page {
    return Intl.message(
      'Exam schedule',
      name: 'examSchedule_page',
      desc: '',
      args: [],
    );
  }

  /// `is accept`
  String get isAccept {
    return Intl.message(
      'is accept',
      name: 'isAccept',
      desc: '',
      args: [],
    );
  }

  /// `You are not have any message`
  String get youAreNotHaveAnyMessage {
    return Intl.message(
      'You are not have any message',
      name: 'youAreNotHaveAnyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Remove score success`
  String get removeScoreSuccess {
    return Intl.message(
      'Remove score success',
      name: 'removeScoreSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Remove score failure`
  String get removeScoreFailure {
    return Intl.message(
      'Remove score failure',
      name: 'removeScoreFailure',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in all the information`
  String get pleaseFillInAllTheInformation {
    return Intl.message(
      'Please fill in all the information',
      name: 'pleaseFillInAllTheInformation',
      desc: '',
      args: [],
    );
  }

  /// `Add score success`
  String get addScoreSuccess {
    return Intl.message(
      'Add score success',
      name: 'addScoreSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Add score failure`
  String get addScoreFailure {
    return Intl.message(
      'Add score failure',
      name: 'addScoreFailure',
      desc: '',
      args: [],
    );
  }

  /// `Update score failure`
  String get updateScoreFailure {
    return Intl.message(
      'Update score failure',
      name: 'updateScoreFailure',
      desc: '',
      args: [],
    );
  }

  /// `Update score success`
  String get updateScoreSuccess {
    return Intl.message(
      'Update score success',
      name: 'updateScoreSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Get subject failure`
  String get getSubjectFailure {
    return Intl.message(
      'Get subject failure',
      name: 'getSubjectFailure',
      desc: '',
      args: [],
    );
  }

  /// `STT`
  String get stt {
    return Intl.message(
      'STT',
      name: 'stt',
      desc: '',
      args: [],
    );
  }

  /// `Birth day`
  String get birthDay {
    return Intl.message(
      'Birth day',
      name: 'birthDay',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete?`
  String get doYouReallyWantToDelete {
    return Intl.message(
      'Do you really want to delete?',
      name: 'doYouReallyWantToDelete',
      desc: '',
      args: [],
    );
  }

  /// `The points will return to the value 0. Please confirm`
  String get thePointsWillReturnToTheValue0PleaseConfirm {
    return Intl.message(
      'The points will return to the value 0. Please confirm',
      name: 'thePointsWillReturnToTheValue0PleaseConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Detail info`
  String get detailInfo {
    return Intl.message(
      'Detail info',
      name: 'detailInfo',
      desc: '',
      args: [],
    );
  }

  /// `Get data specialized failure`
  String get getDataSpecializedFailure {
    return Intl.message(
      'Get data specialized failure',
      name: 'getDataSpecializedFailure',
      desc: '',
      args: [],
    );
  }

  /// `Get data class failure`
  String get getDataClassFailure {
    return Intl.message(
      'Get data class failure',
      name: 'getDataClassFailure',
      desc: '',
      args: [],
    );
  }

  /// `Get data student failure`
  String get getDataStudentFailure {
    return Intl.message(
      'Get data student failure',
      name: 'getDataStudentFailure',
      desc: '',
      args: [],
    );
  }

  /// `Get data subject failure`
  String get getDataSubjectFailure {
    return Intl.message(
      'Get data subject failure',
      name: 'getDataSubjectFailure',
      desc: '',
      args: [],
    );
  }

  /// `Select semester`
  String get selectSemester {
    return Intl.message(
      'Select semester',
      name: 'selectSemester',
      desc: '',
      args: [],
    );
  }

  /// `Select time`
  String get selectTime {
    return Intl.message(
      'Select time',
      name: 'selectTime',
      desc: '',
      args: [],
    );
  }

  /// `Tuition manager`
  String get tuitionManager {
    return Intl.message(
      'Tuition manager',
      name: 'tuitionManager',
      desc: '',
      args: [],
    );
  }

  /// `Payment success`
  String get paymentSuccess {
    return Intl.message(
      'Payment success',
      name: 'paymentSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Payment failure`
  String get paymentFailure {
    return Intl.message(
      'Payment failure',
      name: 'paymentFailure',
      desc: '',
      args: [],
    );
  }

  /// `Search advance`
  String get searchAdvance {
    return Intl.message(
      'Search advance',
      name: 'searchAdvance',
      desc: '',
      args: [],
    );
  }

  /// `Update information success`
  String get updateInformationSuccess {
    return Intl.message(
      'Update information success',
      name: 'updateInformationSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Update information failure`
  String get updateInformationFailure {
    return Intl.message(
      'Update information failure',
      name: 'updateInformationFailure',
      desc: '',
      args: [],
    );
  }

  /// `Add phone number`
  String get addPhoneNumber {
    return Intl.message(
      'Add phone number',
      name: 'addPhoneNumber',
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
