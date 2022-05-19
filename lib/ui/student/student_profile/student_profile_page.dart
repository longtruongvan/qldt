import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/ui/student/student_profile/student_profile_logic.dart';

import '../../../common/app_dimens.dart';
import '../../../utils/authentication.dart';
import '../../auth/login/login_page.dart';
import '../../widgets/button/app_button.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({Key? key}) : super(key: key);

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  final logic = Get.put(StudentProfileLogic());
  final state = Get.find<StudentProfileLogic>().state;

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
