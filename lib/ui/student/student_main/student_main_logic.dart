import 'package:get/get.dart';
import 'package:qldt/ui/student/student_main/student_main_state.dart';

class StudentMainLogic extends GetxController{
  final state = StudentMainState();

  void switchTab() {
    state.pageController.jumpToPage(state.itemSelected.value);
  }
}