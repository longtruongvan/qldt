import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/model/response/department_history_response.dart';
import 'package:qldt/model/response/department_response.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/history_book_department/detail_history_department/detail_history_department_state.dart';

import '../../../../../model/response/person_response.dart';

class DetailHistoryDepartmentLogic extends GetxController {
  final state = DetailHistoryDepartmentState();

  void fetchData(DepartmentHistoryResponse departmentHistoryResponse) {
    state.stateLoading.value = true;

    state.history.value.departmentHistoryResponse = departmentHistoryResponse;
    state.mergeRequest.listen((value) {
      if (value <= 0) {
        state.stateLoading.value = false;
        state.history.refresh();
      }
    });

    state.mergeRequest.value++;
    getPersonById(departmentHistoryResponse.idOrder ?? '', (value) {
      state.mergeRequest.value--;
    });

    state.mergeRequest.value++;
    getDepartmentById(departmentHistoryResponse.idDepartment ?? '', (value) {
      state.mergeRequest.value--;
    });
  }

  void getPersonById(String id, Function(PersonResponse?) callback) {
    FirebaseFirestore.instance.collection('Person').doc(id).get().then((value) {
      if (value.data() != null) {
        var response = PersonResponse.fromJson(value.data()!);
        callback(response);
        state.history.value.personResponse = response;
      } else {
        callback(null);
      }
    }).onError((error, stackTrace) {
      callback(null);
    });
  }

  void getDepartmentById(String id, Function(DepartmentResponse?) callback) {
    FirebaseFirestore.instance
        .collection('Department')
        .doc(id)
        .get()
        .then((value) {
      if (value.data() != null) {
        var response = DepartmentResponse.fromJson(value.data()!);
        callback(response);
        state.history.value.departmentResponse = response;
      } else {
        callback(null);
      }
    }).onError((error, stackTrace) {
      callback(null);
    });
  }
}
