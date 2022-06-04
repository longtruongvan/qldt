import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/response/person_response.dart';
import 'package:qldt/services/auth_service.dart';
import 'package:qldt/ui/auth/login/login_page.dart';
import 'package:qldt/ui/splash/splash_state.dart';
import 'package:qldt/ui/student/student_main/student_main_page.dart';
import 'package:qldt/ui/system_manager/main/system_manager_main_page.dart';
import 'package:qldt/ui/teacher/teacher_main/teacher_main_page.dart';

import '../../utils/authentication.dart';
import '../student/student_register_subject/student_register_subject_page.dart';

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
          FirebaseFirestore.instance
              .collection('Person')
              .doc(uid)
              .update({"avatar": user.photoURL}).then((data) {
            var response = PersonResponse.fromJson(value.data()!);
            final service = Get.find<AuthService>();
            service.updatePerson(response);
            service.updateUser(user);
            if (response.type == PersonType.SV.name) {
              Get.offAll(const StudentMainPage());
            } else if (response.type == PersonType.QTHT.name) {
              Get.offAll(const SystemManagerMainPage());
            } else if (response.type == PersonType.GV.name) {
              Get.offAll(const TeacherMainPage());
            } else {
              Get.offAll(const StudentMainPage());
            }
          });
        } else {
          //checkFirstLogin
          FirebaseFirestore.instance
              .collection('Person')
              .doc(uid)
              .set(PersonResponse(
                id: uid,
                uid: uid,
                name: user.displayName ?? '',
                email: user.email ?? '',
                phone: '',
                type: PersonType.SV.name,
                idScores: [],
                idCourse: [],
                idTuition: [],
                avatar: user.photoURL,
              ).toJson())
              .then((value) {
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
                } else if (response.type == PersonType.GV.name) {
                  Get.offAll(const TeacherMainPage());
                }
              }
            }).catchError((onError) {
              AppSnackBar.showError(title: 'Error', message: 'An error');
            });
          }).catchError((onError) {});
        }
      }).catchError((onError) {
        Get.offAll(const LoginPage());
      });
    } else {
      Get.offAll(const LoginPage());
    }
  }
}
