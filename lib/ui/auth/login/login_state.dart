import 'package:flutter/cupertino.dart';

class LoginState {
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;

  LoginState() {
    emailTextController = TextEditingController(text: '');
    passwordTextController = TextEditingController(text: '');
  }
}
