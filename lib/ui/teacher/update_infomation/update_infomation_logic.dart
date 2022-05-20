import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';

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

  void save(Function() callback) {
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
