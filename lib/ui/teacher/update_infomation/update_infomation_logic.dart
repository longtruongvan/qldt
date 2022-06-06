import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/generated/l10n.dart';

import '../../../services/auth_service.dart';
import 'update_infomation_state.dart';

class UpdateInfomationLogic {
  final state = UpdateInfomationState();
  final authService = Get.find<AuthService>();

  UpdateInfomationLogic() {
    state.phoneTextController.text = authService.person.value?.phone ?? '';
    state.locationTextController.text =
        authService.person.value?.location ?? '';
  }

  bool _isPhoneNumber(String phone) {
    if (phone.isEmpty) {
      return false;
    } else if (phone.isNotEmpty) {
      for (int i = 0; i < phone.length; i++) {
        int? number = int.tryParse(phone[i]);
        if (number == null || number < 0) {
          return false;
        }
      }
      bool mobileValid = RegExp(r'^(?:[+0])?[0-9]{9}$').hasMatch(phone);
      return mobileValid;
    }
    return false;
  }

  void save(Function() callback) {
    if (!_isPhoneNumber(state.phoneTextController.text)) {
      AppSnackBar.showWarning(
          title: S.current.common_warning, message: S.current.update_profile_check_phone);
      return;
    }

    FirebaseFirestore.instance
        .collection('Person')
        .doc(authService.user.value?.uid)
        .update({
      'phone': state.phoneTextController.text,
      'location': state.locationTextController.text
    }).then((value) {
      authService.person.value?.phone = state.phoneTextController.text;
      authService.person.value?.location = state.locationTextController.text;
      callback();
      Get.back(closeOverlays: true);
      AppSnackBar.showSuccess(
        title: 'Success',
        message: 'Update information success',
      );
    }).catchError((onError) {
      AppSnackBar.showError(
        title: 'Error',
        message: 'Update information failure',
      );
    });
  }
}
