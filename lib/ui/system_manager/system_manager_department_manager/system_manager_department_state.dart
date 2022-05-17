import 'package:get/get.dart';
import 'package:qldt/model/response/department_response.dart';

import '../../../model/response/building_response.dart';

class SystemManagerDepartmentState {
  RxBool stateLoading = false.obs;
  RxList<BuildingResponse> listBuilding = <BuildingResponse>[].obs;
  RxList<DepartmentResponse> listDepartment = <DepartmentResponse>[].obs;
  RxMap<BuildingResponse, List<DepartmentResponse>> listData =
      <BuildingResponse, List<DepartmentResponse>>{}.obs;
  RxInt mergeRequest = 0.obs;
}
