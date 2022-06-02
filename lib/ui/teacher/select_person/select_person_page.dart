import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/ui/teacher/select_person/select_person_logic.dart';

class SelectPersonPage extends StatefulWidget {
  const SelectPersonPage({Key? key}) : super(key: key);

  @override
  State<SelectPersonPage> createState() => _SelectPersonPageState();
}

class _SelectPersonPageState extends State<SelectPersonPage> {
  final logic = Get.put(SelectPersonLogic());
  final state = Get.find<SelectPersonLogic>().state;

  @override
  void dispose() {
    Get.delete<SelectPersonLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(),
    );
  }
}
