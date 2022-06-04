import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
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
    // Future(_showLoaderDialog);
    super.initState();
    logic.checkLogin(context: context);
  }

  void _showLoaderDialog() {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: 60,
        height: 60,
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      child:  const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
