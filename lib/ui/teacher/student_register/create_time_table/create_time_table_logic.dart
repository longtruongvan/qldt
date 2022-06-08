import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/generated/l10n.dart';
import 'package:qldt/model/entity/day_of_week_entity.dart';
import 'package:qldt/model/entity/day_off_week_data.dart';
import 'package:qldt/model/entity/lesson_data.dart';
import 'package:qldt/model/entity/lesson_entity.dart';
import 'package:qldt/model/request/subject_register_request.dart';
import 'package:qldt/ui/teacher/student_register/create_time_table/create_time_table_state.dart';

import '../../../../model/entity/course_entity.dart';

class CreateTimeTableLogic extends GetxController {
  final state = CreateTimeTableState();

  CreateTimeTableLogic() {
    fetchData();
  }

  void handlerApproved(List<CourseEntity> course,Function() callback) {
    List<DayOffWeekData> listDayOffWeekData = [];
    List<String> day = [];
    for (int u = 0; u < state.listLesson.length; u++) {
      List<LessonData> dataLesson = state.listLesson[u].dataLesson;
      DayOffWeekData dayOffWeekData = DayOffWeekData();
      for (int k = 0; k < dataLesson.length; k++) {
        if (dataLesson[k].isSelected ?? false) {
          dayOffWeekData.day = state.listLesson[u].dayOffWeek;
          dayOffWeekData.lesson = dataLesson[k].lesson;
          listDayOffWeekData.add(dayOffWeekData);
          day.add(dayOffWeekData.day ?? '');
        }
      }
    }

    state.statusLoading.value = true;
    RxInt dispatchGroup = 0.obs;
    dispatchGroup.listen((p0) {
      if (p0 <= 0) {
        state.statusLoading.value = false;
        callback();
        Get.back(closeOverlays: true);
        AppSnackBar.showSuccess(
          title: S.current.common_success,
          message: S.current.common_success,
        );
      }
    });

    for (int i = 0; i < course.length; i++) {
      dispatchGroup.value++;
      SubjectRegisterRequest subjectRegisterRequest =
          course[i].subjectRegisterRequest ?? SubjectRegisterRequest();
      subjectRegisterRequest.propossedTime?.dayOffWeekData = [];
      subjectRegisterRequest.propossedTime?.dayOffWeekData = listDayOffWeekData;
      subjectRegisterRequest.isAccept = true;
      FirebaseFirestore.instance
          .collection('Course')
          .doc(course[i].subjectRegisterRequest?.id ?? '')
          .set(subjectRegisterRequest.toJson())
          .then((value) {
        dispatchGroup.value--;
      }).onError((error, stackTrace) {
        dispatchGroup.value--;
      });
    }
  }

  void submit(List<CourseEntity> course,Function() callback) {
    bool isSelectedDay = false;
    for (int i = 0; i < state.listDayOfWeek.length; i++) {
      if (state.listDayOfWeek[i].isSelected ?? false) {
        isSelectedDay = true;
        break;
      }
    }

    if (!isSelectedDay) {
      AppSnackBar.showWarning(
        title: S.current.common_warning,
        message: S.current.create_time_table_please_select_calendar,
      );
      return;
    }

    int count = 0;
    for (int i = 0; i < state.listLesson.length; i++) {
      int index = state.listLesson[i].dataLesson
          .indexWhere((element) => (element.isSelected ?? false));
      if (index >= 0) {
        count++;
      }
    }

    if (count < state.listLesson.length) {
      AppSnackBar.showWarning(
        title: S.current.common_warning,
        message: S.current.create_time_table_please_select_calendar,
      );
      return;
    }

    // handler approved
    handlerApproved(course,(){
      callback();
    });

  }

  void checkLessonInDayOffWeek(int index) {
    String day = state.listDayOfWeek[index].day ?? '';
    int position =
        state.listLesson.indexWhere((element) => element.dayOffWeek == day);

    state.listDayOfWeek[index].isSelected =
        !(state.listDayOfWeek[index].isSelected ?? false);

    if (state.listDayOfWeek[index].isSelected ?? false) {
      var lessonEntity =
          LessonEntity(dayOffWeek: day, lesson: '', dataLesson: []);
      for (int x = 0; x < 12; x++) {
        lessonEntity.dataLesson.add(LessonData(
          lesson: '${x + 1}',
          isSelected: false,
        ));
      }
      state.listLesson.add(lessonEntity);
    } else {
      if (position >= 0) {
        state.listLesson.removeAt(position);
      }
    }
    state.listLesson.refresh();
    state.listDayOfWeek.refresh();
  }

  void fetchData() {
    state.listDayOfWeek.add(DayOffWeekEntity(day: 'Mon', isSelected: false));
    state.listDayOfWeek.add(DayOffWeekEntity(day: 'Tues', isSelected: false));
    state.listDayOfWeek.add(DayOffWeekEntity(day: 'Wed', isSelected: false));
    state.listDayOfWeek.add(DayOffWeekEntity(day: 'Thurs', isSelected: false));
    state.listDayOfWeek.add(DayOffWeekEntity(day: 'Fri', isSelected: false));
    state.listDayOfWeek.add(DayOffWeekEntity(day: 'Sat', isSelected: false));
    state.listDayOfWeek.add(DayOffWeekEntity(day: 'Sun', isSelected: false));
  }
}
