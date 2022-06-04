import 'package:get/get.dart';
import 'package:qldt/model/entity/tuition_entity.dart';
import 'package:qldt/model/response/tuition_response.dart';

class DetailTuitionState{
  RxList<TuitionEntity> currentListTuition = <TuitionEntity>[].obs;
  RxList<TuitionEntity> listTuition = <TuitionEntity>[].obs;
}
