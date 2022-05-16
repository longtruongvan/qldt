import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/model/response/building_response.dart';

class AddDepartmentState {
  late TextEditingController nameBuildingTextController;
  late TextEditingController nameDepartmentTextController;
  late TextEditingController locationTextController;
  late TextEditingController descriptionTextController;
  RxInt buildingSelectedPosition = 0.obs;
  RxList listBuilding = <BuildingResponse>[].obs;
  RxBool stateLoading = false.obs;
  RxString idBuildingSelected = ''.obs;

  AddDepartmentState() {
    nameBuildingTextController = TextEditingController(text: '');
    nameDepartmentTextController = TextEditingController(text: '');
    locationTextController = TextEditingController(text: '');
    descriptionTextController = TextEditingController(text: '');
  }
}
