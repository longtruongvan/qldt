import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/model/response/specialized_response.dart';

import '../../../common/app_images.dart';
import '../../../model/response/subject_response.dart';

class StudentRegisterSubjectState {
  RxBool stateLoading = false.obs;
  RxList<SubjectResponse> currentListSubject = <SubjectResponse>[].obs;
  RxList<SubjectResponse> listSubject = <SubjectResponse>[].obs;
  RxList<SpecializedResponse> listSpecialized = <SpecializedResponse>[].obs;
  RxInt mergeRequest = 0.obs;
  RxInt countSubjectSelected = 0.obs;
  Rx<SpecializedResponse> specializedSelected = SpecializedResponse().obs;
  late TextEditingController nameSpecializedTextController;
  late TextEditingController nameSubjectTextController;
  late TextEditingController codeSubjectTextController;
  late TextEditingController numberOfLessonTextController;
  List<String> listIcon = [
    AppImages.icSpecialized,
    AppImages.icSpecialized1,
    AppImages.icSpecialized2,
    AppImages.icSpecialized3,
    AppImages.icSpecialized4,
    AppImages.icSpecialized5,
    AppImages.icSpecialized6,
  ];

  StudentRegisterSubjectState() {
    nameSpecializedTextController = TextEditingController(text: '');
    nameSubjectTextController = TextEditingController(text: '');
    codeSubjectTextController = TextEditingController(text: '');
    numberOfLessonTextController = TextEditingController(text: '');
  }
}
