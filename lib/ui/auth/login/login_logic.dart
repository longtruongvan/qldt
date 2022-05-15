import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/ui/auth/login/login_state.dart';
import 'package:qldt/ui/auth/sign_up/sign_up_page.dart';
import 'package:qldt/ui/home/home_page.dart';
import 'package:qldt/utils/authentication.dart';

class LoginLogic extends GetxController {
  final state = LoginState();

  void showPassword() {
    state.showPassword.value = !state.showPassword.value;
  }

  void goToSignUpScreen() {
    Get.to(const SignUpPage());
  }

  void clickLoginGoogleListener({required BuildContext context}) async{
    var user = await Authentication.signInWithGoogle(context: context);
    if (user != null) {
      Get.to(const HomePage());
    }
  }
  void loginClickListener() async{
    if (state.emailTextController.text.isEmpty) {
      state.emailValidate.value = false;
    } else {
      state.emailValidate.value = true;
    }

    if (state.passwordTextController.text.isEmpty) {
      state.passwordValidate.value = false;
    } else {
      state.passwordValidate.value = true;
    }

    if (!state.emailValidate.value || !state.passwordValidate.value) {
      return;
    }

    await Authentication.signInWithEmailPassword(
      email: state.emailTextController.text,
      password: state.passwordTextController.text,
      callback: (user){

      }
    );
  }
}
