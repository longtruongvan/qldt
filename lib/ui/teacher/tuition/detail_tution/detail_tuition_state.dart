import 'package:get/get.dart';
import 'package:qldt/model/response/tuition_response.dart';

class DetailTuitionState{
  RxList<TuitionResponse> currentListTuition = <TuitionResponse>[].obs;
  RxList<TuitionResponse> listTuition = <TuitionResponse>[].obs;
}
