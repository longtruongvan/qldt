import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/ui/teacher/teacher_score_manager/view_score/view_score_logic.dart';

class ViewScorePage extends StatefulWidget {
  const ViewScorePage({Key? key}) : super(key: key);

  @override
  State<ViewScorePage> createState() => _ViewScorePageState();
}

class _ViewScorePageState extends State<ViewScorePage> {
  final logic = Get.put(ViewScoreLogic());
  final state = Get.find<ViewScoreLogic>().state;

  @override
  void dispose() {
    Get.delete<ViewScoreLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(),
    );
  }
}
