import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qldt/common/app_snack_bar.dart';

import '../services/notification_service.dart';
import '../services/setting_service.dart';

class Authentication {
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    await Get.putAsync(() => SettingService().init());
    await NotificationService().init();
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
      if(user!=null){
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

  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      googleSignIn.signOut();
    } catch (e) {
      // TO DO
    }
  }
}
