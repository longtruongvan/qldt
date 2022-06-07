import 'package:get/get.dart';
import 'package:qldt/model/response/class_response.dart';

class SelectClassState {
  RxBool stateLoading = false.obs;
  RxList<ClassResponse> listClass = <ClassResponse>[].obs;
}
