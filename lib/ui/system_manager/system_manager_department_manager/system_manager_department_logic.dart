import 'package:get/get.dart';
import 'package:qldt/model/response/department_response.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/system_manager_department_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/response/building_response.dart';

class SystemManagerDepartmentLogic extends GetxController{
  final state = SystemManagerDepartmentState();

  SystemManagerDepartmentLogic() {
    fetchData();
    getDataListBuilding();
  }

  void fetchData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    var collectionStream =
        FirebaseFirestore.instance.collection('Department').get().then((value) {
      if (value != null) {
        value.docs.forEach((doc) {
          print(doc.id);
        });
      }
    });
    Stream documentStream = FirebaseFirestore.instance
        .collection('Department')
        .doc('123456789')
        .snapshots();

    if (collectionStream != null) {}

    if (documentStream != null) {}

    FirebaseFirestore.instance
        .collection('Department')
        .snapshots()
        .listen((dataSnapshot) {
      if (dataSnapshot.docs.isNotEmpty) {
        var data = dataSnapshot.docs.map((snapshot) {
          var x = DepartmentResponse.fromJson(snapshot.data());
          print("");
        }).toList();
      }
    });
  }

  void getDataListBuilding() {
    state.stateLoading.value = true;
    state.mergeRequest.listen((value) {
      if (value <= 0) {
        state.listData.clear();
        for (int i = 0; i < state.listBuilding.length; i++) {
          List<DepartmentResponse> departmentArr = [];
          for (int k = 0; k < state.listDepartment.length; k++) {
            if (state.listDepartment.value[k].idBuilding == state.listBuilding.value[i].id) {
              departmentArr.add(state.listDepartment[k]);
            }
          }
          state.listData[state.listBuilding[i]] = departmentArr;
        }
        state.stateLoading.value = false;
      }
    });

    //get list department
    state.mergeRequest.value += 1;
    FirebaseFirestore.instance
        .collection('Department')
        .snapshots()
        .listen((dataSnapshot) {
      if (dataSnapshot.docs.isNotEmpty) {
        state.listDepartment.clear();
        var data = dataSnapshot.docs.map((snapshot) {
          var response = DepartmentResponse.fromJson(snapshot.data());
          state.listDepartment.add(response);
        }).toList();
        state.mergeRequest.value -= 1;
      } else {
        state.mergeRequest.value -= 1;
      }
    });

    // get list building
    state.mergeRequest.value += 1;
    FirebaseFirestore.instance
        .collection('Building')
        .snapshots()
        .listen((dataSnapshot) {
      if (dataSnapshot.docs.isNotEmpty) {
        state.listBuilding.clear();
        var data = dataSnapshot.docs.map((snapshot) {
          var response = BuildingResponse.fromJson(snapshot.data());
          state.listBuilding.add(response);
        }).toList();
        state.mergeRequest.value -= 1;
      } else {
        state.mergeRequest.value -= 1;
      }
    });
  }
}
