import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/generated/l10n.dart';
import 'package:qldt/model/response/class_response.dart';
import 'package:qldt/ui/system_manager/manager_user/select_class/select_class_state.dart';

class SelectClassLogic extends GetxController {
  final state = SelectClassState();

  SelectClassLogic(){
    fetchData();
  }

  void fetchData() {
    state.stateLoading.value = true;
    FirebaseFirestore.instance.collection('Classs').get().then((value) {
      state.listClass.clear();
      value.docs.map((e) {
        var response = ClassResponse.fromJson(e.data());
        state.listClass.add(response);
      }).toList();
      state.stateLoading.value = false;
    }).onError((error, stackTrace) {
      AppSnackBar.showError(
        title: S.current.common_error,
        message: S.current.common_fetch_data_failure,
      );
      state.stateLoading.value = false;
    });
  }
}
