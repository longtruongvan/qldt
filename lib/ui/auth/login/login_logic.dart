import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/ui/auth/login/login_state.dart';
import 'package:qldt/ui/auth/sign_up/sign_up_page.dart';
import 'package:qldt/ui/home/home_page.dart';
import 'package:qldt/utils/authentication.dart';
import 'package:uuid/uuid.dart';

import '../../../common/app_snack_bar.dart';
import '../../../model/response/notification_response.dart';
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
    _handlerCreateDataPerson(user);
  }

  void loginClickListener() async {
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
        callback: (user) {
          _handlerCreateDataPerson(user);
        });
  }

  void _handlerCreateDataPerson(User? user) {
    if (user != null) {
      String fakeAvatar =
          'https://firebasestorage.googleapis.com/v0/b/flutter-app-151a6.appspot.com/o/leaves-7101716_1280.png?alt=media&token=7474428c-854f-4494-ad1f-ec60cc675415';
      state.statusLoading.value = true;
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
              state.statusLoading.value = false;
              AppSnackBar.showError(title: 'Error', message: 'An error');
            });
          }).catchError((onError) {
            state.statusLoading.value = false;
          });
        }
      }).catchError((onError) {
        state.statusLoading.value = false;
        Get.offAll(const LoginPage());
      });
    } else {
      Get.offAll(const LoginPage());
    }
  }

  void _createFirstNotification(String idNotification, String idReceiver) {
    FirebaseFirestore.instance
        .collection('Notification')
        .doc(idNotification)
        .set(NotificationResponse(
          id: idNotification,
          isRead: false,
          idReceiver: idReceiver,
          title:
              'Welcome to the training management system of University of Transport Technology',
          time: DateTime.now().toString(),
          avatarUrl:
              'https://firebasestorage.googleapis.com/v0/b/flutter-app-151a6.appspot.com/o/eb3ef-logo-utt-noborder.png?alt=media&token=c2436ff4-a34c-4290-96fd-f61a1cb95dc0',
          typeNotification: 'WELCOME',
        ).toJson())
        .then((value) {})
        .catchError((onError) {});
  }
}
