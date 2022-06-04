import 'package:get/get.dart';
import 'package:qldt/common/app_images.dart';
import 'package:qldt/model/entity/course_entity.dart';
import 'package:qldt/model/request/subject_register_request.dart';
import 'package:qldt/model/response/person_response.dart';

class ListRegisterState {
  RxBool stateLoading = false.obs;
  Rx<PersonResponse> personResponse = PersonResponse().obs;
  RxList<CourseEntity> listCourse = <CourseEntity>[].obs;
  RxInt mergeRequest = 0.obs;
  List imgCourses = [
    AppImages.imgSpecialized1,
    AppImages.imgCoruse,
    AppImages.imgSubjectManager,
    AppImages.imgSpecialized,
    AppImages.imgManagerUserItem,
    AppImages.imgDepartmentManager,
    AppImages.imgSpecialized1,
    AppImages.imgCoruse,
    AppImages.imgSubjectManager,
    AppImages.imgSpecialized,
  ];
}
