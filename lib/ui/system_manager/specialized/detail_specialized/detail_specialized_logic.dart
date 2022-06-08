import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/generated/l10n.dart';
import 'package:qldt/model/response/specialized_response.dart';
import 'package:qldt/ui/system_manager/specialized/detail_specialized/detail_specialized_state.dart';

class DetailSpecializedLogic extends GetxController {
  final state = DetailSpecializedState();

  void initData(SpecializedResponse specializedResponse) {
    state.specialized.value = specializedResponse;
  }

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
        title: S.current.common_success,
        message: S.current.deleteSpecializedSuccess,
      );
    }).catchError((onError) {
      AppSnackBar.showError(
        title: S.current.common_error,
        message: S.current.deleteSpecializedFailure,
      );
    });
  }
}
