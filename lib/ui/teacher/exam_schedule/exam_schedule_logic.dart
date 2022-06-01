import 'package:get/get.dart';
import 'package:qldt/ui/teacher/exam_schedule/exam_schedule_state.dart';

class ExamScheduleLogic extends GetxController {
  final state = ExamScheduleState();

  void changeMonth(DateTime dateTime) {
    state.focusDay.value = dateTime;
    // update();
  }

  void changeDay(DateTime dateTime){
    state.focusDay.value = dateTime;
    state.focusDay.refresh();
    // update();
  }
}
