import 'package:get/get.dart';

import '../../../../../model/entity/history_department_entity.dart';

class DetailHistoryDepartmentState{
  RxBool stateLoading = false.obs;
  RxInt mergeRequest = 0.obs;
  Rx<HistoryDepartmentEntity> history = HistoryDepartmentEntity().obs;
}