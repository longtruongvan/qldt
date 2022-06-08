import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/ui/teacher/tuition/tuition_state.dart';

import '../../../common/app_snack_bar.dart';
import '../../../generated/l10n.dart';
import '../../../model/response/class_response.dart';
import '../../../model/response/person_response.dart';
import '../../../model/response/specialized_response.dart';
import '../../splash/splash_logic.dart';

class TuitionLogic extends GetxController {
  final state = TuitionState();

  TuitionLogic() {
    fetchData();
  }

  void searchHandler(String value) {
    if (value == '') {
      state.listPersonResponse.clear();
      state.listPersonResponse.addAll(state.currentListPersonResponse);
      return;
    }
    String content = "";
    state.listPersonResponse.clear();
    for (int i = 0; i < state.currentListPersonResponse.length; i++) {
      content = '${state.currentListPersonResponse[i].name}';
      if (content.toLowerCase().contains(value.toLowerCase())) {
        state.listPersonResponse.add(state.currentListPersonResponse[i]);
      }
    }
  }

  void fetchData() {
    // Get Person
    FirebaseFirestore.instance.collection('Person').get().then((value) {
      state.currentListPersonResponse.clear();
      state.listPersonResponse.clear();
      value.docs.map((e) {
        var response = PersonResponse.fromJson(e.data());
        if (response.type == PersonType.SV.name) {
          state.currentListPersonResponse.add(response);
          state.listPersonResponse.add(response);
        }
      }).toList();
      if (state.searchTextController.text != '') {
        searchHandler(state.searchTextController.text);
      }
    }).catchError((onError) {
      AppSnackBar.showError(
          title: S.current.common_error, message: S.current.getDataStudentFailure);
    });
  }
}
