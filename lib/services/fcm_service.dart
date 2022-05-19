import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService{
  static void getToken(){
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value){
      print(value);
    });
  }

  static void handlerMessageInForeground(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message);
    });
  }
}