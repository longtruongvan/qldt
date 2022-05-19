import 'package:get/get.dart';
import 'package:qldt/model/entity/subject_entity.dart';
import 'package:qldt/model/response/subject_response.dart';

import '../../../model/entity/day_of_week_entity.dart';
import '../../../model/response/specialized_response.dart';

class StudentRegisterSubjectNextState {
  RxBool statusLoading = false.obs;
  RxInt mergeRequest = 0.obs;
  RxList<SubjectEntity> listSubjectEntity = <SubjectEntity>[].obs;
  RxList<SubjectResponse> listSubject = <SubjectResponse>[].obs;
  Rx<SpecializedResponse> specializedResponse = SpecializedResponse().obs;
}
