import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/model/response/person_response.dart';
import 'package:qldt/services/auth_service.dart';
import 'package:qldt/ui/auth/login/login_page.dart';
import 'package:qldt/ui/splash/splash_state.dart';
import 'package:qldt/ui/student/student_main/student_main_page.dart';
import 'package:qldt/ui/system_manager/main/system_manager_main_page.dart';
import 'package:qldt/ui/teacher/teacher_main/teacher_main_page.dart';

import '../../utils/authentication.dart';

enum PersonType {
  SV,
  GV,
  QTHT,
}

class SplashLogic extends GetxController {
  final state = SplashState();


  void checkLogin({required BuildContext context}) async {
    await Firebase.initializeApp();
    await Get.putAsync(() => AuthService().init());
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    // check login when open app again
    User? user = firebaseAuth.currentUser;
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
}
