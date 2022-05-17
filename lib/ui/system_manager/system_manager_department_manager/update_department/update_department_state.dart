import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/response/building_response.dart';
import '../../../../model/response/department_response.dart';

class UpdateDepartmentState{
  RxBool statusLoading = false.obs;
  late TextEditingController nameBuildingTextController;
  late TextEditingController nameDepartmentTextController;
  late TextEditingController locationTextController;
  late TextEditingController descriptionTextController;
  RxInt buildingSelectedPosition = 0.obs;
  RxList<BuildingResponse> listBuilding = <BuildingResponse>[].obs;
  RxBool stateLoading = false.obs;
  RxString idBuildingSelected = ''.obs;
  Rx<BuildingResponse> buildingResponse = BuildingResponse().obs;
  Rx<DepartmentResponse> departmentResponse = DepartmentResponse().obs;

  UpdateDepartmentState() {
    nameBuildingTextController = TextEditingController(text: '');
    nameDepartmentTextController = TextEditingController(text: '');
    locationTextController = TextEditingController(text: '');
    descriptionTextController = TextEditingController(text: '');
  }
}