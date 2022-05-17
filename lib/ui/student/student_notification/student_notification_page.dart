import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/ui/student/student_notification/student_notification_logic.dart';

class StudentNotificationPage extends StatefulWidget {
  const StudentNotificationPage({Key? key}) : super(key: key);

  @override
  State<StudentNotificationPage> createState() =>
      _StudentNotificationPageState();
}

class _StudentNotificationPageState extends State<StudentNotificationPage> {
  final logic = Get.put(StudentNotificationLogic());
  final state = Get.find<StudentNotificationLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
