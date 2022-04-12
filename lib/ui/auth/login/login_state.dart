import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginState {
  RxBool showPassword = false.obs;
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;

  LoginState() {
    emailTextController = TextEditingController(text: '');
    passwordTextController = TextEditingController(text: '');
  }
}
