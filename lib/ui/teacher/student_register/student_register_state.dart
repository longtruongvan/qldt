import 'package:get/get.dart';
import 'package:qldt/model/entity/course_entity.dart';

class StudentRegisterState{
  RxBool stateLoading = false.obs;
  RxList<CourseEntity> listCourse = <CourseEntity>[].obs;
  RxMap<String,List<CourseEntity>> course = <String,List<CourseEntity>>{}.obs;
  RxInt mergeRequest = 0.obs;
  Rx<DateTime> focusDay = DateTime.now().obs;
  RxList<CourseEntity> currentListCourse = <CourseEntity>[].obs;
  RxList<CourseEntity> mon = <CourseEntity>[].obs;
  RxList<CourseEntity> tues = <CourseEntity>[].obs;
  RxList<CourseEntity> wed = <CourseEntity>[].obs;
  RxList<CourseEntity> thurs = <CourseEntity>[].obs;
  RxList<CourseEntity> fri = <CourseEntity>[].obs;
  RxList<CourseEntity> sat = <CourseEntity>[].obs;
  RxList<CourseEntity> sun = <CourseEntity>[].obs;
}