import 'package:get/get.dart';
import 'package:qldt/model/entity/score_entity.dart';
import 'package:qldt/ui/teacher/teacher_score_manager/view_score/view_score_page.dart';

import '../../../../model/response/subject_response.dart';

class ViewScoreState {
  Rx<ScoreViewType> viewType = ScoreViewType.subject.obs;

  RxList<SubjectResponse> listAllSubjectResponse = <SubjectResponse>[].obs;
  RxList<SubjectResponse> listSubjectWithSpecialized = <SubjectResponse>[].obs;
  Rx<SubjectResponse> subjectSelected = SubjectResponse().obs;

  RxList<ScoreEntity> listScoreEntity = <ScoreEntity>[].obs;

  RxInt mergeRequest = 0.obs;
  RxBool statusLoading = false.obs;
}
