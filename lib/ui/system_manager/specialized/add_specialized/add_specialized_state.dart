import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSpecializedState {
  late TextEditingController nameTextController;
  late TextEditingController displayNameTextController;
  RxBool stateLoading = false.obs;

  AddSpecializedState() {
    nameTextController = TextEditingController();
    displayNameTextController = TextEditingController();
  }
}
