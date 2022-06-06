import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/response/specialized_response.dart';
import 'package:qldt/ui/system_manager/specialized/add_specialized/add_specialized_state.dart';
import 'package:uuid/uuid.dart';

class AddSpecializedLogic extends GetxController {
  final state = AddSpecializedState();

  void submitButtonClickListener() {
    state.stateLoading.value = true;
    if (state.nameTextController.text == '' ||
        state.displayNameTextController.text == '' ||
        state.codeTextController.text == '') {
      AppSnackBar.showWarning(
        title: 'Warning',
        message: 'You have not provided enough information. Please check again',
      );
      state.stateLoading.value = false;
      return;
    }

    String id = const Uuid().v1();
    FirebaseFirestore.instance
        .collection('Specialized')
        .doc(id)
        .set(SpecializedResponse(
          id: id,
          name: state.nameTextController.text,
          displayName: state.displayNameTextController.text,
          code: state.codeTextController.text,
        ).toJson())
        .then((value) {
      Get.back(closeOverlays: true);
      AppSnackBar.showSuccess(
        title: 'Success',
        message: 'Add specialized success',
      );
      state.stateLoading.value = false;
    }).catchError((onError) {
      state.stateLoading.value = false;
    });
  }
}
