import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_theme.dart';
import 'package:qldt/router/router_config.dart';
import 'package:qldt/services/auth_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:qldt/services/setting_service.dart';

import 'generated/l10n.dart';
import 'services/notification_service.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  // description
  importance: Importance.max,
);

Future initService() async {
  await Firebase.initializeApp();
  await Get.putAsync(() => AuthService().init());
  await NotificationService().init(); // <----
  await Get.putAsync(() => SettingService().init());

  if (Platform.isIOS) {
    await FirebaseMessaging.instance.requestPermission();
  }
  final deviceToken = await FirebaseMessaging.instance.getToken();
  print('Device token $deviceToken');

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon,
              // other properties...
            ),
          ));
    }
  });
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initService();
  runApp(const MyApp());
}

Future<void> saveTokenToDatabase(String token) async {
  // Assume user is logged in for this example
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  await FirebaseFirestore.instance.collection('Person').doc(userId).update({
    'tokens': FieldValue.arrayUnion([token]),
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: RouterConfig.splash,
      getPages: RouterConfig.getPages,
      locale: Get.find<SettingService>().currentLocale.value,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        fontFamily: AppTheme.fontFamily,
        backgroundColor: AppColors.whiteColor,
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    ));
  }
}

