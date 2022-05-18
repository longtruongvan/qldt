import 'package:get/get.dart';
import 'package:qldt/ui/teacher/teacher_main/teacher_main_sate.dart';

class TeacherMainLogic extends GetxController{
  final state = TeacherMainState();

  void switchTab() {
    state.pageController.jumpToPage(state.itemSelected.value);
  }
}