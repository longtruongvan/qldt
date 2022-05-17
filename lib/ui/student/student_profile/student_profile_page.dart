import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/ui/student/student_profile/student_profile_logic.dart';

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
    return Container();
  }
}
