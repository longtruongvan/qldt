import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/response/specialized_response.dart';
import 'package:qldt/ui/system_manager/specialized/specialized_state.dart';

import '../../../generated/l10n.dart';

class SpecializedLogic extends GetxController {
  final state = SpecializedState();

  SpecializedLogic() {
    fetchData();
  }

  void searchHandler(String value) {
    if (value == '') {
      state.listSpecialized.clear();
      state.listSpecialized.addAll(state.currentListSpecialized);
      return;
    }
    String content = "";
    state.listSpecialized.clear();
    for (int i = 0; i < state.currentListSpecialized.length; i++) {
      content =
          '${state.currentListSpecialized[i].displayName} (${state.currentListSpecialized[i].name})';
      if (content.toLowerCase().contains(value.toLowerCase())) {
        state.listSpecialized.add(state.currentListSpecialized[i]);
      }
    }
  }

  void fetchData() {
    state.stateLoading.value = true;
    FirebaseFirestore.instance.collection("Specialized").get().then((data) {
      state.listSpecialized.clear();
      state.currentListSpecialized.clear();
      data.docs.map((e) {
        var response = SpecializedResponse.fromJson(e.data());
        response.icon = state.listIcon[Random().nextInt(6)];
        state.listSpecialized.add(response);
        state.currentListSpecialized.add(response);
      }).toList();
      state.stateLoading.value = false;
      if (state.searchTextController.text != '') {
        searchHandler(state.searchTextController.text);
      }
    }).catchError((onError) {
      state.stateLoading.value = false;
      AppSnackBar.showError(
        title: S.current.common_error,
        message: S.current.common_fetch_data_failure,
      );
    });
  }
}
