import 'package:get/get.dart';
import 'package:qldt/model/entity/course_entity.dart';
import 'package:qldt/model/request/subject_register_request.dart';
import 'package:qldt/model/response/person_response.dart';

class ListRegisterState {
  RxBool stateLoading = false.obs;
  Rx<PersonResponse> personResponse = PersonResponse().obs;
  RxList<CourseEntity> listCourse = <CourseEntity>[].obs;
  RxInt mergeRequest = 0.obs;
}
