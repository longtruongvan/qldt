import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/response/specialized_response.dart';

class DetailSubjectState{
  late TextEditingController nameSpecializedTextController;
  late TextEditingController nameSubjectTextController;
  late TextEditingController codeSubjectTextController;
  late TextEditingController numberOfLessonTextController;
  RxBool stateLoading = false.obs;
  RxBool isEdit = false.obs;
  RxList<SpecializedResponse> listSpecialized = <SpecializedResponse>[].obs;
  Rx<SpecializedResponse> specializedSelected = SpecializedResponse().obs;

  DetailSubjectState(){
    nameSpecializedTextController = TextEditingController(text: '');
    nameSubjectTextController = TextEditingController(text: '');
    codeSubjectTextController = TextEditingController(text: '');
    numberOfLessonTextController = TextEditingController(text: '');
  }
}