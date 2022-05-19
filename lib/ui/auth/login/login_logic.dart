import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/ui/auth/login/login_state.dart';
import 'package:qldt/ui/auth/sign_up/sign_up_page.dart';
import 'package:qldt/ui/home/home_page.dart';
import 'package:qldt/utils/authentication.dart';

import '../../../model/response/person_response.dart';
import '../../../services/auth_service.dart';
import '../../splash/splash_logic.dart';
import '../../student/student_main/student_main_page.dart';
import '../../system_manager/main/system_manager_main_page.dart';
import '../../teacher/teacher_main/teacher_main_page.dart';
import 'login_page.dart';

class LoginLogic extends GetxController {
  final state = LoginState();

  void showPassword() {
    state.showPassword.value = !state.showPassword.value;
  }

  void goToSignUpScreen() {
    Get.to(const SignUpPage());
  }

  void clickLoginGoogleListener({required BuildContext context}) async {
    var user = await Authentication.signInWithGoogle(context: context);
    if (user != null) {
      String uid = user.uid;
      FirebaseFirestore.instance
          .collection('Person')
          .doc(uid)
          .get()
          .then((value) {
        if (value.data() != null) {
          var response = PersonResponse.fromJson(value.data()!);
          final service = Get.find<AuthService>();
          service.updatePerson(response);
          service.updateUser(user);
          if (response.type == PersonType.SV.name) {
            Get.offAll(const StudentMainPage());
          } else if (response.type == PersonType.QTHT.name) {
            Get.offAll(const SystemManagerMainPage());
          } else {
            Get.offAll(const TeacherMainPage());
          }
        } else {
          Get.offAll(const LoginPage());
        }
      }).catchError((onError) {
        Get.offAll(const LoginPage());
      });
    }else{
      Get.offAll(const LoginPage());
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
        callback: (user) {});
  }
}
