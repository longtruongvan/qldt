import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/model/response/building_response.dart';
import 'package:qldt/model/response/department_response.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/add_department/add_department_state.dart';
import 'package:uuid/uuid.dart';

import '../../../../generated/l10n.dart';

class AddDepartmentLogic extends GetxController{
  final state = AddDepartmentState();

  AddDepartmentLogic() {
    getDataListBuilding();
  }

  void pickImageHandler() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print("longtv");
    }
    // if(pickedFile!=null){
    //   print("longtv");
    //   File imageFile = File(pickedFile.path);
    // }
  }

  void updateItemSelected(BuildingResponse response) {
    for (int i = 0; i < state.listBuilding.value.length; i++) {
      if (state.listBuilding.value[i].id == response.id) {
        state.listBuilding.value[i].isSelected = true;
        state.nameBuildingTextController.text =
            state.listBuilding.value[i].name;
        state.idBuildingSelected.value =
            state.listBuilding.value[i].id ?? '';
      } else {
        state.listBuilding.value[i].isSelected = false;
      }
    }
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
        state.stateLoading.value = false;
      } else {
        state.stateLoading.value = false;
      }
    });
  }

  void addDepartmentHandel() {
    if (state.nameBuildingTextController.text == '' ||
        state.nameDepartmentTextController.text == '' ||
        state.locationTextController.text == '' ||
        state.descriptionTextController.text == '') {
      Get.snackbar(
        S.current.common_error,
        S.current.youHaveNotProvidedEnoughInformation,
        backgroundColor: AppColors.warningColor,
        colorText: AppColors.whiteColor,
      );
      return;
    }
    state.stateLoading.value = true;
    String uuid = const Uuid().v1();
    FirebaseFirestore.instance
        .collection('Department')
        .doc(uuid)
        .set(DepartmentResponse(
          id: uuid,
          idBuilding: state.idBuildingSelected.value,
          description: state.descriptionTextController.text,
          location: state.locationTextController.text,
          name: state.nameDepartmentTextController.text,
          status: false,
        ).toJson())
        .then((value) {
      state.stateLoading.value = false;
      Get.back(closeOverlays: true);
      Get.snackbar(
        S.current.common_success,
        S.current.addDepartmentSuccess,
        backgroundColor: AppColors.successColor,
        colorText: AppColors.whiteColor,
      );
    }).catchError((onError) {
      state.stateLoading.value = false;
      Get.snackbar(
        S.current.common_error,
        S.current.addDepartmentFailure,
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
      );
    });
  }
}
