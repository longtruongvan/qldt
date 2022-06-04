import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/response/specialized_response.dart';
import 'package:qldt/ui/system_manager/specialized/update_specialized/update_specialized_state.dart';

class UpdateSpecializedLogic extends GetxController {
  final state = UpdateSpecializedState();

  void initData(SpecializedResponse specializedResponse) {
    state.specializedResponse.value = specializedResponse;
    state.nameTextController.text = state.specializedResponse.value.name ?? '';
    state.displayNameTextController.text =
        state.specializedResponse.value.displayName ?? '';
  }

  void submitButtonClickListener(Function() callback) {
    state.stateLoading.value = true;
    if (state.nameTextController.text == '' ||
        state.displayNameTextController.text == '') {
      AppSnackBar.showWarning(
        title: 'Warning',
        message: 'You have not provided enough information. Please check again',
      );
      return;
    }

    FirebaseFirestore.instance
        .collection('Specialized')
        .doc(state.specializedResponse.value.id)
        .update({
      'name': state.nameTextController.text,
      'displayName': state.displayNameTextController.text
    }).then((value) {
      Get.back(closeOverlays: true);
      AppSnackBar.showSuccess(
        title: 'Success',
        message: 'Update specialized success',
      );
      state.stateLoading.value = false;
      callback();
    }).catchError((onError) {
      state.stateLoading.value = false;
    });
  }
}
