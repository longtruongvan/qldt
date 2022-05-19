import 'package:get/get.dart';

import 'app_colors.dart';

class AppSnackBar {
  static void showError({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.errorColor,
      colorText: AppColors.whiteColor,
    );
  }

  static void showWarning({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.warningColor,
      colorText: AppColors.whiteColor,
    );
  }

  static void showSuccess({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.successColor,
      colorText: AppColors.whiteColor,
    );
  }
}
