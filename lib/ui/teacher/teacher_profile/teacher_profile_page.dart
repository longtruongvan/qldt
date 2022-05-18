import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/ui/teacher/teacher_profile/teacher_profile_logic.dart';

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
    return Container();
  }
}
