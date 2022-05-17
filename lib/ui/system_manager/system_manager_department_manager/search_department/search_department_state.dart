import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/model/response/building_response.dart';

import '../../../../model/response/department_response.dart';

class SearchDepartmentState {
  late TextEditingController searchTextController;
  RxBool stateLoading = false.obs;
  RxInt mergeRequest = 0.obs;
  RxList<DepartmentResponse> listDepartment = <DepartmentResponse>[].obs;
  RxList<BuildingResponse> listBuilding = <BuildingResponse>[].obs;

  RxList<DepartmentResponse> currentListDepartment = <DepartmentResponse>[].obs;
  RxList<BuildingResponse> currentListBuilding = <BuildingResponse>[].obs;

  SearchDepartmentState(){
    searchTextController = TextEditingController(text: '');
  }
}
