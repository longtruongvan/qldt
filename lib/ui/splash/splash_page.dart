import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/ui/system_manager/main/system_manager_main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.offAll(
        () => const SystemManagerMainPage(),
        //     () => (FirebaseAuth.instance.currentUser != null)
        //     ? const HomePage()
        //     : const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
