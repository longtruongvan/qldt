import 'package:get/get.dart';
import 'package:qldt/model/response/class_response.dart';
import 'package:qldt/model/response/person_response.dart';
import 'package:qldt/model/response/specialized_response.dart';
import 'package:qldt/model/response/subject_response.dart';

import '../../../generated/l10n.dart';

class TeacherScoreManagerState {
  RxList<SpecializedResponse> currentListSpecialized =
      <SpecializedResponse>[].obs;
  RxList<SpecializedResponse> listSpecialized = <SpecializedResponse>[].obs;
  Rx<SpecializedResponse> specializedSelected = SpecializedResponse().obs;

  RxList<ClassResponse> currentListClassResponse = <ClassResponse>[].obs;
  RxList<ClassResponse> listClassResponse = <ClassResponse>[].obs;
  Rx<ClassResponse> classResponseSelected = ClassResponse().obs;
  RxList<String> yearSchool = <String>[].obs;
  Rx<String> yearSchoolSelected = S.current.common_all.obs;

  RxList<PersonResponse> currentListPersonResponse = <PersonResponse>[].obs;
  RxList<PersonResponse> listPersonResponse = <PersonResponse>[].obs;
  Rx<PersonResponse> personResponseSelected = PersonResponse().obs;

  RxList<SubjectResponse> currentListSubjectResponse = <SubjectResponse>[].obs;
  RxList<SubjectResponse> listSubjectResponse = <SubjectResponse>[].obs;
  Rx<SubjectResponse> subjectResponseSelected = SubjectResponse().obs;

  RxList<String> listSemester = <String>[
    "1",
    "2",
  ].obs;
  RxInt semesterPositionSelected = 0.obs;

  RxBool spec1Active = false.obs;
  RxBool spec2Active = false.obs;
  RxBool spec3Active = false.obs;
  RxBool spec4Active = false.obs;
}
