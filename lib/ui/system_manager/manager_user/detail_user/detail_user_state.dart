import 'package:get/get.dart';
import 'package:qldt/model/response/class_response.dart';
import 'package:qldt/model/response/specialized_response.dart';

class DetailUserState {
  RxBool statusLoading = false.obs;
  RxInt mergeRequest = 0.obs;
  Rx<ClassResponse> classResponse = ClassResponse().obs;
  Rx<SpecializedResponse> specializedResponse = SpecializedResponse().obs;
}
