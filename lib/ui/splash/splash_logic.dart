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
import 'package:uuid/uuid.dart';

import '../../model/response/notification_response.dart';
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
      String fakeAvatar =
          'https://firebasestorage.googleapis.com/v0/b/flutter-app-151a6.appspot.com/o/leaves-7101716_1280.png?alt=media&token=7474428c-854f-4494-ad1f-ec60cc675415';
      FirebaseFirestore.instance
          .collection('Person')
          .doc(uid)
          .get()
          .then((value) {
        if (value.data() != null) {
          FirebaseFirestore.instance
              .collection('Person')
              .doc(uid)
              .update({"avatar": user.photoURL ?? fakeAvatar}).then((data) {
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
          String idFirstNotification = const Uuid().v1();
          //checkFirstLogin
          FirebaseFirestore.instance
              .collection('Person')
              .doc(uid)
              .set(PersonResponse(
                id: uid,
                uid: uid,
                name: user.displayName ?? '${user.email}',
                email: user.email ?? '',
                phone: '',
                type: PersonType.SV.name,
                idScores: [],
                idCourse: [],
                idTuition: [],
                idNotification: [idFirstNotification],
                avatar: user.photoURL ?? fakeAvatar,
              ).toJson())
              .then((value) {
            _createFirstNotification(idFirstNotification, uid);
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

  void _createFirstNotification(String idNotification,String idReceiver) {
    FirebaseFirestore.instance
        .collection('Notification')
        .doc(idNotification)
        .set(NotificationResponse(
      id: idNotification,
      isRead: false,
      idReceiver: idReceiver,
      title: 'Welcome to the training management system of University of Transport Technology',
      time: DateTime.now().toString(),
      avatarUrl: 'https://firebasestorage.googleapis.com/v0/b/flutter-app-151a6.appspot.com/o/eb3ef-logo-utt-noborder.png?alt=media&token=c2436ff4-a34c-4290-96fd-f61a1cb95dc0',
      typeNotification: 'WELCOME',
    ).toJson())
        .then((value) {})
        .catchError((onError) {});
  }
}
