import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_theme.dart';
import 'package:qldt/router/router_config.dart';
import 'package:qldt/utils/authentication.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Future(initService);
  runApp(const MyApp());
}

void initService() async{
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: RouterConfig.splash,
      getPages: RouterConfig.getPages,
      theme: ThemeData(
        fontFamily: AppTheme.fontFamily,
        backgroundColor: AppColors.whiteColor,
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    );
  }
}