import 'package:get/get.dart';
import 'package:qldt/model/entity/detail_exam_entity.dart';

class DetailExamScheduleState {
  Rx<DetailExamEntity> detailExamEntity = DetailExamEntity().obs;
  RxInt mergeRequest = 0.obs;
}
