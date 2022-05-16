import 'package:get/get.dart';

import '../../../model/response/building_response.dart';

class SystemManagerDepartmentState{
  RxBool stateLoading = false.obs;
  RxList<BuildingResponse> listBuilding = <BuildingResponse>[].obs;

}