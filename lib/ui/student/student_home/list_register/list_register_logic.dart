import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/entity/course_entity.dart';
import 'package:qldt/model/request/subject_register_request.dart';
import 'package:qldt/model/response/person_response.dart';
import 'package:qldt/model/response/specialized_response.dart';
import 'package:qldt/model/response/subject_response.dart';
import 'package:qldt/services/auth_service.dart';
import 'package:qldt/ui/student/student_home/list_register/list_register_state.dart';

class ListRegisterLogic extends GetxController {
  final state = ListRegisterState();
  final authService = Get.find<AuthService>();

  ListRegisterLogic() {
    fetchData();
  }

  void fetchData() {
    state.listCourse.clear();
    state.stateLoading.value = true;
    state.mergeRequest.listen((value) {
      if (value <= 0) {}
    });

    FirebaseFirestore.instance
        .collection('Person')
        .doc(authService.person.value?.uid ?? '')
        .get()
        .then((value) {
      var response = PersonResponse.fromJson(value.data() ?? {});
      state.personResponse.value = response;

      for (int i = 0;
          i < (state.personResponse.value.idCourse ?? []).length;
          i++) {
        state.mergeRequest.value++;
        String idCourse = state.personResponse.value.idCourse![i];
        getCourseById(idCourse, i);
      }
      state.stateLoading.value = false;
    }).catchError((onError) {
      AppSnackBar.showError(title: 'Error', message: 'Fetch data error');
      state.stateLoading.value = false;
    });
  }

  void getCourseById(String id, int index) {
    FirebaseFirestore.instance.collection('Course').doc(id).get().then((value) {
      var response = SubjectRegisterRequest.fromJson(value.data() ?? {});
      if (value.data() != null) {
        var courseEntity = CourseEntity(subjectRegisterRequest: response);
        getSpecializedById(response.idSpecialized ?? '', (value) {
          courseEntity.specializedResponse = value;
          if (courseEntity.subjectRegisterRequest != null) {
            state.listCourse.add(courseEntity);
          }
        });
        getSubjectById(response.subjectIds ?? '', (value) {
          courseEntity.subjectResponse = value;
          if (courseEntity.specializedResponse != null) {
            state.listCourse.add(courseEntity);
          }
        });
        if (index <= 9) {
          courseEntity.image = state.imgCourses[index];
        } else {
          String position = index
              .toString()
              .substring(index.toString().length - 1, index.toString().length);
          courseEntity.image = state.imgCourses[int.tryParse(position)??0];
        }
      }
      state.mergeRequest.value--;
    }).catchError((onError) {
      // AppSnackBar.showError(title: 'Error', message: 'Fetch data error');
      state.mergeRequest.value--;
    });
  }

  void getSpecializedById(String id, Function(SpecializedResponse) callback) {
    FirebaseFirestore.instance
        .collection('Specialized')
        .doc(id)
        .get()
        .then((value) {
      var response = SpecializedResponse.fromJson(value.data() ?? {});
      if (value.data() != null) {
        callback(response);
      }
    }).catchError((onError) {
      // AppSnackBar.showError(title: 'Error', message: 'Fetch data error');
    });
  }

  void getSubjectById(String id, Function(SubjectResponse) callback) {
    FirebaseFirestore.instance
        .collection('Subject')
        .doc(id)
        .get()
        .then((value) {
      var response = SubjectResponse.fromJson(value.data() ?? {});
      if (value.data() != null) {
        callback(response);
      }
    }).catchError((onError) {
      // AppSnackBar.showError(title: 'Error', message: 'Fetch data error');
    });
  }
}
