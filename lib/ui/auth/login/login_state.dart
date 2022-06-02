import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginState {
  RxBool showPassword = false.obs;
  RxBool emailValidate = true.obs;
  RxBool passwordValidate = true.obs;
  RxBool statusLoading = false.obs;
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;

  LoginState() {
    emailTextController = TextEditingController(text: '');
    passwordTextController = TextEditingController(text: '');
  }
}
