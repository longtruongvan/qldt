import 'package:get/get.dart';
import 'package:qldt/model/entity/lesson_entity.dart';

import '../../../../model/entity/day_of_week_entity.dart';

class CreateTimeTableState {
  RxList<DayOffWeekEntity> listDayOfWeek = <DayOffWeekEntity>[].obs;
  RxList<LessonEntity> listLesson = <LessonEntity>[].obs;
  RxBool statusLoading = false.obs;
}
