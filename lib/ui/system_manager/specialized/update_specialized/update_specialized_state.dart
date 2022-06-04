import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/model/response/specialized_response.dart';

class UpdateSpecializedState {
  late TextEditingController nameTextController;
  late TextEditingController displayNameTextController;
  RxBool stateLoading = false.obs;
  Rx<SpecializedResponse> specializedResponse = SpecializedResponse().obs;

  UpdateSpecializedState() {
    nameTextController = TextEditingController();
    displayNameTextController = TextEditingController();
  }
}
