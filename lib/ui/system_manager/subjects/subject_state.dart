import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/model/response/subject_response.dart';

import '../../../common/app_images.dart';

class SubjectState{
  RxBool stateLoading = false.obs;
  RxList<SubjectResponse> listSubject = <SubjectResponse>[].obs;
  RxList<SubjectResponse> currentListSubject = <SubjectResponse>[].obs;
  List<String> listIcon = [
    AppImages.icSpecialized,
    AppImages.icSpecialized1,
    AppImages.icSpecialized2,
    AppImages.icSpecialized3,
    AppImages.icSpecialized4,
    AppImages.icSpecialized5,
    AppImages.icSpecialized6,
  ];

  late TextEditingController searchTextController;
  SubjectState(){
    searchTextController = TextEditingController();
  }
}