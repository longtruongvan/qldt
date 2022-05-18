import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/ui/teacher/teacher_notification/teacher_notification_logic.dart';

class TeacherNotificationPage extends StatefulWidget {
  const TeacherNotificationPage({Key? key}) : super(key: key);

  @override
  State<TeacherNotificationPage> createState() =>
      _TeacherNotificationPageState();
}

class _TeacherNotificationPageState extends State<TeacherNotificationPage> {
  final logic = Get.put(TeacherNotificationLogic());
  final state = Get.find<TeacherNotificationLogic>().state;

  @override
  void dispose() {
    Get.delete<TeacherNotificationLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
