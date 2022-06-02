import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
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
        .doc(state.listTuition[index].id)
        .update({'state': true}).then((value) {
      AppSnackBar.showSuccess(title: 'Success', message: 'Payment success');
      state.listTuition[index].state = true;
      state.listTuition.refresh();
    }).catchError((onError) {
      AppSnackBar.showError(title: 'Error', message: 'Payment failure');
    });
  }

  void fetchData(PersonResponse personResponse) {
    state.currentListTuition.clear();
    state.listTuition.clear();
    for (int i = 0; i < (personResponse.idTuition ?? []).length; i++) {
      getTuitionById(personResponse.idTuition![i], () {});
    }
  }

  void getTuitionById(String idTuition, Function() callback) {
    FirebaseFirestore.instance
        .collection('Tuition')
        .doc(idTuition)
        .get()
        .then((value) {
      var response = TuitionResponse.fromJson(value.data() ?? {});
      if (value.data() != null) {
        state.currentListTuition.add(response);
        state.listTuition.add(response);
      }
    }).catchError((onError) {
      print(onError);
    });
  }
}
