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
    emailTextController = TextEditingController(text: 'truongvanlong25102000@gmail.com');
    passwordTextController = TextEditingController(text: 'Truongvanlong@2000');
  }
}
