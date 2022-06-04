import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/model/entity/tuition_entity.dart';
import 'package:qldt/model/response/person_response.dart';
import 'package:qldt/model/response/tuition_response.dart';
import 'package:qldt/services/auth_service.dart';

import '../../../../common/app_snack_bar.dart';
import 'detail_tuition_state.dart';

class DetailTuitionLogic {
  final state = DetailTuitionState();
  final authService = Get.find<AuthService>();

  void payment(int index) {
    FirebaseFirestore.instance
        .collection('Tuition')
        .doc(state.listTuition[index].tuitionResponse.id)
        .update({'state': true}).then((value) {
      AppSnackBar.showSuccess(title: 'Success', message: 'Payment success');
      state.listTuition[index].tuitionResponse.state = true;
      state.listTuition.refresh();
    }).catchError((onError) {
      AppSnackBar.showError(title: 'Error', message: 'Payment failure');
    });
  }

  void fetchData(List<PersonResponse> personResponses) {
    state.currentListTuition.clear();
    state.listTuition.clear();

    for (int u = 0; u < personResponses.length; u++) {
      for (int i = 0; i < (personResponses[u].idTuition ?? []).length; i++) {
        getTuitionById(personResponses[u].idTuition![i], (response) {
          if (response != null) {
            state.currentListTuition.add(TuitionEntity(
              tuitionResponse: response,
              personResponse: personResponses[u],
            ));
            state.listTuition.add(TuitionEntity(
              tuitionResponse: response,
              personResponse: personResponses[u],
            ));
          }
        });
      }
    }
  }

  void getTuitionById(String idTuition, Function(TuitionResponse?) callback) {
    FirebaseFirestore.instance
        .collection('Tuition')
        .doc(idTuition)
        .get()
        .then((value) {
      var response = TuitionResponse.fromJson(value.data() ?? {});
      if (value.data() != null) {
        callback(response);
      } else {
        callback(null);
      }
    }).catchError((onError) {
      callback(null);
    });
  }
}
