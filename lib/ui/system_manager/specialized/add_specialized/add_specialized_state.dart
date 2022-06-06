import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSpecializedState {
  late TextEditingController codeTextController;
  late TextEditingController nameTextController;
  late TextEditingController displayNameTextController;
  RxBool stateLoading = false.obs;

  AddSpecializedState() {
    codeTextController = TextEditingController();
    nameTextController = TextEditingController();
    displayNameTextController = TextEditingController();
  }
}
