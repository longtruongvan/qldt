import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/ui/teacher/teacher_profile/teacher_profile_logic.dart';

import '../../../common/app_dimens.dart';
import '../../../utils/authentication.dart';
import '../../auth/login/login_page.dart';
import '../../widgets/button/app_button.dart';

class TeacherProfilePage extends StatefulWidget {
  const TeacherProfilePage({Key? key}) : super(key: key);

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePageState();
}

class _TeacherProfilePageState extends State<TeacherProfilePage> {
  final logic = Get.put(TeacherProfileLogic());
  final state = Get.find<TeacherProfileLogic>().state;

  @override
  void dispose() {
    Get.delete<TeacherProfileLogic>();
    super.dispose();
  }

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
