import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/model/response/class_response.dart';

class CreateUserState {
  RxBool statusLoading = false.obs;
  Rx<ClassResponse> classResponseSelected = ClassResponse().obs;
  late TextEditingController numberTextEditingController;

  CreateUserState() {
    numberTextEditingController = TextEditingController(text: '');
  }
}
