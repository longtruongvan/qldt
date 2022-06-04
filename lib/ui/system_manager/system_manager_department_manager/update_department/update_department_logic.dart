import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/model/response/department_response.dart';

import '../../../../common/app_colors.dart';
import '../../../../model/response/building_response.dart';
import 'update_department_state.dart';

class UpdateDepartmentLogic {
  final state = UpdateDepartmentState();

  void setData(DepartmentResponse departmentResponse,
      BuildingResponse buildingResponse) {
    state.buildingResponse.value = buildingResponse;
    state.departmentResponse.value = departmentResponse;
    state.nameDepartmentTextController.text = departmentResponse.name ?? '';
    state.locationTextController.text = departmentResponse.location ?? '';
    state.descriptionTextController.text = departmentResponse.description ?? '';
    state.nameBuildingTextController.text = buildingResponse.name ?? '';
    getDataListBuilding();
  }

  void getDataListBuilding() {
    state.stateLoading.value = true;
    FirebaseFirestore.instance
        .collection('Building')
        .snapshots()
        .listen((dataSnapshot) {
      if (dataSnapshot.docs.isNotEmpty) {
        state.listBuilding.value.clear();
        var data = dataSnapshot.docs.map((snapshot) {
          var response = BuildingResponse.fromJson(snapshot.data());
          state.listBuilding.value.add(response);
        }).toList();
        for (int i = 0; i < state.listBuilding.length; i++) {
          if (state.listBuilding[i].id == state.buildingResponse.value.id) {
            state.buildingSelectedPosition.value = i;
            state.idBuildingSelected.value = state.listBuilding[i].id ?? '';
            state.listBuilding[i].isSelected = true;
          } else {
            state.listBuilding[i].isSelected = false;
          }
        }
        state.stateLoading.value = false;
      } else {
        state.stateLoading.value = false;
      }
    });
  }

  void updateItemSelected(BuildingResponse response) {
    for (int i = 0; i < state.listBuilding.length; i++) {
      if (state.listBuilding[i].id == response.id) {
        state.listBuilding[i].isSelected = true;
        state.nameBuildingTextController.text =
            state.listBuilding[i].name ?? '';
        state.idBuildingSelected.value = state.listBuilding[i].id ?? '';
      } else {
        state.listBuilding[i].isSelected = false;
      }
    }
  }

  void updateDepartmentHandler(Function() callback) {
    if (state.nameBuildingTextController.text == '' ||
        state.nameDepartmentTextController.text == '' ||
        state.locationTextController.text == '' ||
        state.descriptionTextController.text == '') {
      Get.snackbar(
        'Error',
        'You have not provided enough information',
        backgroundColor: AppColors.warningColor,
        colorText: AppColors.whiteColor,
      );
      return;
    }

    state.stateLoading.value = true;
    FirebaseFirestore.instance
        .collection('Department')
        .doc(state.departmentResponse.value.id)
        .update(DepartmentResponse(
          idBuilding: state.idBuildingSelected.value,
          description: state.descriptionTextController.text,
          location: state.locationTextController.text,
          name: state.nameDepartmentTextController.text,
          status: state.departmentResponse.value.status,
          id: state.departmentResponse.value.id,
        ).toJson())
        .then((value) {
      state.stateLoading.value = false;
      callback();
      Get.back(closeOverlays: true);
      Get.snackbar(
        'Success',
        'Update department success',
        backgroundColor: AppColors.successColor,
        colorText: AppColors.whiteColor,
      );
    }).onError((error, stackTrace) {
      state.stateLoading.value = false;
      Get.snackbar(
        'Error',
        'Update department failure',
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
      );
    });
  }
}
