import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/response/class_response.dart';
import '../../../../model/response/person_response.dart';
import '../../../../model/response/specialized_response.dart';

class CreateTuitionState {
  RxList<SpecializedResponse> currentListSpecialized =
      <SpecializedResponse>[].obs;
  RxList<SpecializedResponse> listSpecialized = <SpecializedResponse>[].obs;
  Rx<SpecializedResponse> specializedSelected = SpecializedResponse().obs;

  RxList<PersonResponse> currentListPersonResponse = <PersonResponse>[].obs;
  RxList<PersonResponse> listPersonResponse = <PersonResponse>[].obs;
  Rx<PersonResponse> personResponseSelected = PersonResponse().obs;

  RxList<ClassResponse> currentListClassResponse = <ClassResponse>[].obs;
  RxList<ClassResponse> listClassResponse = <ClassResponse>[].obs;
  Rx<ClassResponse> classResponseSelected = ClassResponse().obs;

  RxList<String> yearSchool = <String>[].obs;
  Rx<String> yearSchoolSelected = 'All'.obs;
  RxInt semesterPositionSelected = 0.obs;
  RxList<String> listSemester = <String>[
    "1",
    "2",
  ].obs;

  late TextEditingController tuitionTextController;
  RxBool statusLoading = false.obs;

  CreateTuitionState() {
    tuitionTextController = TextEditingController(text: '');
  }
}
