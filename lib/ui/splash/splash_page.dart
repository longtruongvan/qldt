import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/ui/splash/splash_logic.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final logic = Get.put(SplashLogic());
  final state = Get.find<SplashLogic>().state;


  @override
  void dispose() {
    Get.delete<SplashLogic>();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    logic.checkLogin(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
