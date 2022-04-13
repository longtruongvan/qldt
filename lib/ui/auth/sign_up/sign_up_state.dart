import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpState {
  late TextEditingController nameTextController;
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;

  RxBool showPassword = false.obs;

  SignUpState() {
    nameTextController = TextEditingController(text: '');
    emailTextController = TextEditingController(text: '');
    passwordTextController = TextEditingController(text: '');
  }
}
