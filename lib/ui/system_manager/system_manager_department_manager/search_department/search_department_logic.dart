import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/model/response/building_response.dart';
import 'package:qldt/model/response/department_response.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/search_department/search_department_state.dart';

import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';

class SearchDepartmentLogic extends GetxController {
  final state = SearchDepartmentState();

  SearchDepartmentLogic() {
    fetchData();
  }

  void searchHandler(String text) {
    if (text == '') {
      state.listDepartment.clear();
      state.listBuilding.clear();
      state.listBuilding.addAll(state.currentListBuilding);
      state.listDepartment.addAll(state.currentListDepartment);
      state.listDepartment.refresh();
      state.listBuilding.refresh();
      return;
    }
    var arrDepartment = <DepartmentResponse>[];
    var arrBuilding = <BuildingResponse>[];
    for (int u = 0; u < state.currentListDepartment.length; u++) {
      if (('P: ${state.currentListDepartment[u].name ?? ''}').toLowerCase().contains(text.toLowerCase())) {
        arrDepartment.add(state.currentListDepartment[u]);
        arrBuilding.add(state.currentListBuilding[u]);
      }
    }

    state.listDepartment.clear();
    state.listBuilding.clear();
    state.listBuilding.addAll(arrBuilding);
    state.listDepartment.addAll(arrDepartment);
    state.listDepartment.refresh();
    state.listBuilding.refresh();
  }

  void fetchData() {
    state.stateLoading.value = true;

    state.mergeRequest.listen((value) {
      if (value <= 0) {
        state.stateLoading.value = false;

        // map listDepartment with listBuilding -> listDepartment.size = listBuilding.size
        var arrNewData = <BuildingResponse>[];
        for (int i = 0; i < state.listDepartment.length; i++) {
          for (int k = 0; k < state.listBuilding.length; k++) {
            if (state.listDepartment[i].idBuilding ==
                state.listBuilding[k].id) {
              arrNewData.add(state.listBuilding[k]);
              break;
            }
          }
        }
        state.listBuilding.clear();
        state.listBuilding.addAll(arrNewData);

        // flag base data while search
        state.currentListBuilding.clear();
        state.currentListDepartment.clear();
        state.currentListBuilding.addAll(state.listBuilding);
        state.currentListDepartment.addAll(state.listDepartment);

        // refresh list
        state.currentListDepartment.refresh();
        state.currentListBuilding.refresh();
        state.listDepartment.refresh();
        state.listBuilding.refresh();
        if(state.searchTextController.text!=''){
          searchHandler(state.searchTextController.text);
        }
      }
    });

    state.mergeRequest.value += 1;
    FirebaseFirestore.instance
        .collection('Department').get().then((dataSnapshot){
      if (dataSnapshot.docs.isNotEmpty) {
        state.listDepartment.value.clear();
        var response = dataSnapshot.docs.map((value) {
          DepartmentResponse departmentResponse =
              DepartmentResponse.fromJson(value.data());
          state.listDepartment.value.add(departmentResponse);
        }).toList();
      } else {
        state.listDepartment.clear();
      }
      state.mergeRequest.value -= 1;
    }).catchError((onError){
      Get.snackbar(
        S.current.common_error,
        S.current.common_fetch_data_failure,
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
      );
      state.mergeRequest.value -= 1;
    });

    state.mergeRequest.value += 1;
    FirebaseFirestore.instance
        .collection('Building')
        .get()
        .then((dataSnapshot) {
      if (dataSnapshot.docs.isNotEmpty) {
        state.listBuilding.value.clear();
        var response = dataSnapshot.docs.map((value) {
          BuildingResponse buildingResponse =
              BuildingResponse.fromJson(value.data());
          state.listBuilding.value.add(buildingResponse);
        }).toList();
      } else {
        state.listDepartment.clear();
      }
      state.mergeRequest.value -= 1;
    }).catchError((onError){
      Get.snackbar(
        S.current.common_error,
        S.current.common_fetch_data_failure,
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
      );
      state.mergeRequest.value -= 1;
    });
  }
}
