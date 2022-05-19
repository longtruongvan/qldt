import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_images.dart';

import '../../../model/response/specialized_response.dart';

class SpecializedState {
  RxBool stateLoading = false.obs;
  RxList<SpecializedResponse> listSpecialized = <SpecializedResponse>[].obs;
  RxList<SpecializedResponse> currentListSpecialized = <SpecializedResponse>[].obs;

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
  SpecializedState(){
    searchTextController = TextEditingController();
  }
}
