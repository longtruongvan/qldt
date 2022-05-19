import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/ui/system_manager/specialized/detail_specialized/detail_specialized_state.dart';

class DetailSpecializedLogic extends GetxController {
  final state = DetailSpecializedState();

  void deleteSpecialized({required String? id}) {
    if (id == null) {
      return;
    }

    FirebaseFirestore.instance
        .collection('Specialized')
        .doc(id)
        .delete()
        .then((value) {
      Get.back();
      Get.back(closeOverlays: true);
      AppSnackBar.showSuccess(
        title: 'Success',
        message: 'Delete specialized success',
      );
    }).catchError((onError) {
      AppSnackBar.showError(
        title: 'Error',
        message: 'Delete specialized failure',
      );
    });
  }
}
