import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:uuid/uuid.dart';

import '../model/response/notification_response.dart';
import '../model/response/person_response.dart';
import '../services/auth_service.dart';
import '../services/notification_service.dart';
import '../services/setting_service.dart';
import '../ui/splash/splash_logic.dart';

class Authentication {
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9090);
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    // check login when open app again
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      return user;
    }
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await firebaseAuth.signInWithCredential(authCredential);
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == '') {}
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        //TO DO
      }
    }
    return user;
  }

  static Future<void> signInWithEmailPassword({
    required String email,
    required String password,
    required Function(User?) callback,
  }) async {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null && event.emailVerified) {
        //event.emailVerified check email real
      } else {}
    });

    UserCredential? user;
    try {
      user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (user != null) {
        callback(user.user);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        AppSnackBar.showError(
            title: 'Error', message: 'No user found for that email.`');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        AppSnackBar.showError(
            title: 'Error', message: 'Wrong password provided for that user.');
      }
    }
  }

  static void _createFirstNotification(
      String idNotification, String idReceiver) {
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

  static Future<void> registerWithEmailPassword({
    required String email,
    required String password,
    required String idClass,
    required String codeStudent,
    required String idSpecialized,
    required Function() callback,
  }) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      RxInt dispatchGroup = 0.obs;
      dispatchGroup.listen((p0) async {
        if(p0<=0){
          await FirebaseAuth.instance.signOut();
          callback();
        }
      });

      dispatchGroup.value++;
      dispatchGroup.value++;

      var user = userCredential.user;
      if (user != null) {
        String fakeAvatar =
            'https://firebasestorage.googleapis.com/v0/b/flutter-app-151a6.appspot.com/o/leaves-7101716_1280.png?alt=media&token=7474428c-854f-4494-ad1f-ec60cc675415';
        String uid = user.uid;
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
              idClass: idClass,
              code: codeStudent,
              idSpecialized: idSpecialized,
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
          dispatchGroup.value--;
        }).catchError((onError) {
          dispatchGroup.value--;
          AppSnackBar.showError(title: 'Error', message: 'An error');
        });

        FirebaseFirestore.instance.collection('Classs').doc(idClass).update({
          'idStudent': FieldValue.arrayUnion([uid])
        }).then((value) {
          dispatchGroup.value--;
        }).onError((error, stackTrace) {
          dispatchGroup.value--;
        });
      }
    } catch (e) {}
  }

  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      googleSignIn.signOut();
    } catch (e) {
      // TO DO
    }
  }
}
