import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/model/entity/type_exam.dart';
import 'package:qldt/model/response/class_response.dart';
import 'package:qldt/model/response/specialized_response.dart';
import 'package:qldt/model/response/subject_response.dart';

class CreateExamScheduleState {
  RxList<SpecializedResponse> listSpecialized = <SpecializedResponse>[].obs;
  Rx<SpecializedResponse> specializedSelected = SpecializedResponse().obs;
  Rx<ClassResponse> classSelected = ClassResponse().obs;
  Rx<SubjectResponse> subjectSelected = SubjectResponse().obs;
  Rx<TypeExamEntity> typeExamSelected = TypeExamEntity().obs;
  RxList<SubjectResponse> listSubject = <SubjectResponse>[].obs;
  RxList<TypeExamEntity> listTypeExam = <TypeExamEntity>[].obs;
  RxList<ClassResponse> listClassResponse = <ClassResponse>[].obs;
  RxInt mergeRequest = 0.obs;
  RxBool stateLoading = false.obs;
  Rx<TimeOfDay> timeStart = TimeOfDay.now().obs;
  Rx<TimeOfDay> timeEnd = TimeOfDay.now().obs;
  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;

  late TextEditingController timeStartTextController;
  late TextEditingController timeEndTextController;
  late TextEditingController locationTextController;
  late TextEditingController titleTextController;

  CreateExamScheduleState(){
    timeEndTextController = TextEditingController(text: '');
    timeStartTextController = TextEditingController(text: '');
    locationTextController = TextEditingController(text: '');
    titleTextController = TextEditingController(text: '');
  }
}
