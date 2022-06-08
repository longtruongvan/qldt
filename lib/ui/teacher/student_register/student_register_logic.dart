import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/model/request/subject_register_request.dart';
import 'package:qldt/services/auth_service.dart';
import 'package:qldt/ui/teacher/student_register/student_register_state.dart';

import '../../../common/app_snack_bar.dart';
import '../../../generated/l10n.dart';
import '../../../model/entity/course_entity.dart';
import '../../../model/response/person_response.dart';
import '../../../model/response/specialized_response.dart';
import '../../../model/response/subject_response.dart';

class StudentRegisterLogic extends GetxController {
  final state = StudentRegisterState();
  final auth = Get.find<AuthService>();
  StudentRegisterLogic() {
    fetchData();
  }

  void checkCountAdd(){

  }

  void fetchData() {
    state.stateLoading.value = true;
    RxInt dispatchGroup = 0.obs;
    dispatchGroup.listen((value) {
      if (value <= 0) {
        List<SubjectResponse> keys = [];
        Map<String, List<CourseEntity>> map = {};
        for (int i = 0; i < state.listCourse.length; i++) {
          if (map[state.listCourse[i].subjectResponse?.id] == null) {
            map[state.listCourse[i].subjectResponse?.id??''] = [];
            keys.add(state.listCourse[i].subjectResponse??SubjectResponse());
          }
          map[state.listCourse[i].subjectResponse?.id]?.add(state.listCourse[i]);
        }

        Map<String, List<CourseEntity>> result = {};
        map.forEach((String key, value) {
          for(int i=0;i<keys.length;i++){
            if(key==keys[i].id){
              result[keys[i].name??''] = value;
            }
          }
        });
        state.course.clear();
        state.course.addAll(result);
        print('longtv');
      }
    });

    state.listCourse.clear();
    state.course.clear();
    FirebaseFirestore.instance.collection('Course').get().then((value) {
      value.docs.map((e) {
        var response = SubjectRegisterRequest.fromJson(e.data());
        // check môn học trong khoa
        if (response.idSpecialized == auth.person.value?.idSpecialized) {
          dispatchGroup.value++;

          RxInt d = 0.obs;
          CourseEntity courseEntity = CourseEntity();
          courseEntity.subjectRegisterRequest = response;

          d.listen((value) {
            if (value <= 0) {
              if (courseEntity.subjectResponse != null &&
                  courseEntity.subjectResponse?.id != null &&
                  courseEntity.subjectResponse?.id != '') {
                state.listCourse.add(courseEntity);
              }
              dispatchGroup.value--;
            }
          });

          d.value++;
          getSubjectById(
            response.subjectIds ?? '',
            (subjectResponse) {
              courseEntity.subjectResponse = subjectResponse;
              d.value--;
            },
          );

          d.value++;
          getPersonById(response.idSender ?? '', (personResponse) {
            courseEntity.personResponse = personResponse;
            d.value--;
          });
        }
      }).toList();
      state.stateLoading.value = false;
    }).catchError((onError) {
      AppSnackBar.showError(
          title: S.current.common_error, message: 'Fetch data error');
      state.stateLoading.value = false;
    });
  }

  void getSpecializedById(String id, Function(SpecializedResponse?) callback) {
    FirebaseFirestore.instance
        .collection('Specialized')
        .doc(id)
        .get()
        .then((value) {
      var response = SpecializedResponse.fromJson(value.data() ?? {});
      if (value.data() != null) {
        callback(response);
      } else {
        callback(null);
      }
    }).catchError((onError) {
      callback(null);
      // AppSnackBar.showError(title: 'Error', message: 'Fetch data error');
    });
  }

  void getPersonById(String id, Function(PersonResponse?) callback) {
    FirebaseFirestore.instance.collection('Person').doc(id).get().then((value) {
      var response = PersonResponse.fromJson(value.data() ?? {});
      if (value.data() != null) {
        callback(response);
      } else {
        callback(null);
      }
    }).catchError((onError) {
      callback(null);
      // AppSnackBar.showError(title: 'Error', message: 'Fetch data error');
    });
  }

  void getSubjectById(String id, Function(SubjectResponse?) callback) {
    FirebaseFirestore.instance
        .collection('Subject')
        .doc(id)
        .get()
        .then((value) {
      var response = SubjectResponse.fromJson(value.data() ?? {});
      if (value.data() != null) {
        if (response.name == null || response.name == '') {
          callback(null);
        } else {
          callback(response);
        }
      } else {
        callback(null);
      }
    }).catchError((onError) {
      callback(null);
      // AppSnackBar.showError(title: 'Error', message: 'Fetch data error');
    });
  }
}
