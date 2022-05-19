import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/model/response/specialized_response.dart';

class AddSubjectState {
  RxBool stateLoading = false.obs;
  late TextEditingController nameSpecializedTextController;
  late TextEditingController nameSubjectTextController;
  late TextEditingController codeSubjectTextController;
  late TextEditingController numberOfLessonTextController;
  RxList<SpecializedResponse> listSpecialized = <SpecializedResponse>[].obs;
  Rx<SpecializedResponse> specializedSelected = SpecializedResponse().obs;

  AddSubjectState() {
    nameSpecializedTextController = TextEditingController(text: '');
    nameSubjectTextController = TextEditingController(text: '');
    codeSubjectTextController = TextEditingController(text: '');
    numberOfLessonTextController = TextEditingController(text: '');
  }
}
