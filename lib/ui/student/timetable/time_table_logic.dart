import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/request/subject_register_request.dart';
import 'package:qldt/model/response/person_response.dart';

import '../../../model/entity/course_entity.dart';
import '../../../model/response/specialized_response.dart';
import '../../../model/response/subject_response.dart';
import '../../../services/auth_service.dart';
import 'time_table_state.dart';

class TimeTableLogic extends GetxController {
  final state = TimeTableState();
  final auth = Get.find<AuthService>();

  TimeTableLogic() {
    fetchData();
  }

  void changeMonth(DateTime dateTime) {
    state.focusDay.value = dateTime;
    // update();
  }

  void changeDay(DateTime dateTime) {
    state.focusDay.value = dateTime;
    state.focusDay.refresh();
    checkDayFocusWithTimeTable();
    // update();
  }

  void checkDayFocusWithTimeTable(){
    // Weekday constants that are returned by [weekday] method:
    // static const int monday = 1;
    // static const int tuesday = 2;
    // static const int wednesday = 3;
    // static const int thursday = 4;
    // static const int friday = 5;
    // static const int saturday = 6;
    // static const int sunday = 7;
    // static const int daysPerWeek = 7;

    switch(DateTime.parse(state.focusDay.toString()).weekday){
      case 1:
        state.currentListCourse.clear();
        state.currentListCourse.addAll(state.mon);
        break;
      case 2:
        state.currentListCourse.clear();
        state.currentListCourse.addAll(state.tues);
        break;
      case 3:
        state.currentListCourse.clear();
        state.currentListCourse.addAll(state.wed);
        break;
      case 4:
        state.currentListCourse.clear();
        state.currentListCourse.addAll(state.thurs);
        break;
      case 5:
        state.currentListCourse.clear();
        state.currentListCourse.addAll(state.fri);
        break;
      case 6:
        state.currentListCourse.clear();
        state.currentListCourse.addAll(state.sat);
        break;
      case 7:
        state.currentListCourse.clear();
        state.currentListCourse.addAll(state.sun);
        break;
    }
  }

  void fetchData() {
    state.stateLoading.value = true;
    RxInt dispatchGroup = 0.obs;
    dispatchGroup.listen((value) {
      if (value <= 0) {
        state.currentListCourse.clear();
        state.mon.clear();
        state.tues.clear();
        state.wed.clear();
        state.thurs.clear();
        state.fri.clear();
        state.sat.clear();
        state.sun.clear();
        print('LONGTV @@ ${state.listCourse.length}');
        for (int i = 0; i < state.listCourse.length; i++) {
          List<String> dayOfWeek = state.listCourse[i].subjectRegisterRequest
                  ?.propossedTime?.dayOfWeek ??
              [];
          for (int k = 0; k < dayOfWeek.length; k++) {
            switch (dayOfWeek[k]) {
              case 'Mon':
                state.mon.add(state.listCourse[i]);
                break;
              case 'Tues':
                state.tues.add(state.listCourse[i]);
                break;
              case 'Wed':
                state.wed.add(state.listCourse[i]);
                break;
              case 'Thurs':
                state.thurs.add(state.listCourse[i]);
                break;
              case 'Fri':
                state.fri.add(state.listCourse[i]);
                break;
              case 'Sat':
                state.sat.add(state.listCourse[i]);
                break;
              case 'Sun':
                state.sun.add(state.listCourse[i]);
                break;
            }
          }
        }
        checkDayFocusWithTimeTable();
      }
    });

    FirebaseFirestore.instance
        .collection('Person')
        .doc(auth.person.value?.uid ?? '')
        .get()
        .then((value) {
      var response = PersonResponse.fromJson(value.data() ?? {});
      state.personResponse.value = response;

      for (int i = 0;
          i < (state.personResponse.value.idCourse ?? []).length;
          i++) {
        dispatchGroup.value++;
        String idCourse = state.personResponse.value.idCourse![i];
        getCourseById(idCourse, () {
          dispatchGroup.value--;
        });
      }
      state.stateLoading.value = false;
    }).catchError((onError) {
      AppSnackBar.showError(title: 'Error', message: 'Fetch data error');
      state.stateLoading.value = false;
    });
  }

  void getCourseById(String id, Function() callback) {
    state.stateLoading.value = true;
    FirebaseFirestore.instance.collection('Course').doc(id).get().then((value) {
      var response = SubjectRegisterRequest.fromJson(value.data() ?? {});
      if (value.data() != null) {
        RxInt dispatchGroup = 0.obs;
        dispatchGroup.value++;
        dispatchGroup.value++;

        dispatchGroup.listen((p0) {
          if (p0 <= 0) {
            callback();
          }
        });
        var courseEntity = CourseEntity(subjectRegisterRequest: response);
        getSpecializedById(response.idSpecialized ?? '', (value) {
          courseEntity.specializedResponse = value;
          if (courseEntity.subjectRegisterRequest != null) {
            state.listCourse.add(courseEntity);
          }
          dispatchGroup.value--;
        });
        getSubjectById(response.subjectIds ?? '', (value) {
          courseEntity.subjectResponse = value;
          if (courseEntity.specializedResponse != null) {
            state.listCourse.add(courseEntity);
          }
          dispatchGroup.value--;
        });
      }else{
        callback();
      }
    }).catchError((onError) {
      callback();
      // AppSnackBar.showError(title: 'Error', message: 'Fetch data error');
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
      }else{
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
        callback(response);
      }else{
        callback(null);
      }
    }).catchError((onError) {
      callback(null);
      // AppSnackBar.showError(title: 'Error', message: 'Fetch data error');
    });
  }
}
