import 'package:get/get.dart';
import 'package:qldt/model/response/building_response.dart';
import 'package:qldt/model/response/department_response.dart';

class DetailDepartmentState {
  RxBool statusLoading = false.obs;
  Rx<DepartmentResponse> departmentResponse = DepartmentResponse().obs;
  Rx<BuildingResponse> buildingResponse = BuildingResponse().obs;
  RxList<BuildingResponse> listBuildingResponse = <BuildingResponse>[].obs;
  RxString nameBuilding = ''.obs;
}
