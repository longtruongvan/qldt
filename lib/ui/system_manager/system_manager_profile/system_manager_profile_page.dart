import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_dimens.dart';
import 'package:qldt/ui/auth/login/login_page.dart';
import 'package:qldt/ui/widgets/button/app_button.dart';
import 'package:qldt/utils/authentication.dart';

class SystemManagerProfilePage extends StatefulWidget {
  const SystemManagerProfilePage({Key? key}) : super(key: key);

  @override
  State<SystemManagerProfilePage> createState() =>
      _SystemManagerProfilePageState();
}

class _SystemManagerProfilePageState extends State<SystemManagerProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            child: Column(
              children: [],
            ),
          ),
          Positioned(
            child: AppButton(
              title: 'Logout',
              onPress: () {
                Authentication.signOut();
                Get.offAll(const LoginPage());
              },
            ),
            bottom: AppDimens.spacingNormal,
            right: AppDimens.spacingNormal,
            left: AppDimens.spacingNormal,
          )
        ],
      ),
    );
  }
}
