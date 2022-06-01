import 'package:get/get.dart';
import 'package:qldt/model/response/class_response.dart';
import 'package:qldt/model/response/person_response.dart';
import 'package:qldt/model/response/specialized_response.dart';

class TeacherScoreManagerState {
  RxList<SpecializedResponse> currentListSpecialized =
      <SpecializedResponse>[].obs;
  RxList<SpecializedResponse> listSpecialized = <SpecializedResponse>[].obs;
  Rx<SpecializedResponse> specializedSelected = SpecializedResponse().obs;

  RxList<ClassResponse> currentListClassResponse = <ClassResponse>[].obs;
  RxList<ClassResponse> listClassResponse = <ClassResponse>[].obs;
  Rx<ClassResponse> classResponseSelected = ClassResponse().obs;

  RxList<PersonResponse> currentListPersonResponse = <PersonResponse>[].obs;
  RxList<PersonResponse> listPersonResponse = <PersonResponse>[].obs;
  Rx<PersonResponse> personResponseSelected = PersonResponse().obs;

  RxBool spec1Active = false.obs;
  RxBool spec2Active = false.obs;
  RxBool spec3Active = false.obs;
}
