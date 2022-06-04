import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/entity/type_exam.dart';
import 'package:qldt/model/response/class_response.dart';
import 'package:qldt/model/response/example_schedule_response.dart';
import 'package:qldt/model/response/notification_response.dart';
import 'package:qldt/model/response/specialized_response.dart';
import 'package:qldt/model/response/subject_response.dart';
import 'package:qldt/services/auth_service.dart';
import 'package:qldt/ui/teacher/exam_schedule/add/add_exam_schedule_state.dart';
import 'package:uuid/uuid.dart';

class CreateExamScheduleLogic extends GetxController {
  final state = CreateExamScheduleState();
  final authService = Get.find<AuthService>();

  CreateExamScheduleLogic() {
    fetchData();
  }

  void submit(DateTime dayCreate) {
    if (state.specializedSelected.value.id == null ||
        state.classSelected.value.id == null ||
        state.subjectSelected.value.id == null ||
        state.typeExamSelected.value.name == null ||
        state.timeEndTextController.text == '' ||
        state.timeStartTextController.text == '' ||
        state.locationTextController.text == '' ||
        state.titleTextController.text == '') {
      AppSnackBar.showWarning(
          title: 'Warning',
          message: 'You have not filled in enough information');
      return;
    }

    state.stateLoading.value = true;
    String id = const Uuid().v1();

    FirebaseFirestore.instance
        .collection('Notification')
        .doc(id)
        .set(NotificationResponse(
          id: id,
          isRead: false,
          idExamSchedule: id,
          title: 'Đã có: ${state.titleTextController.text}',
          time: DateTime.now().toString(),
          idSender: authService.person.value?.id,
          avatarUrl: authService.user.value?.photoURL,
          typeNotification: 'LICH_THI',
        ).toJson())
        .then((value) {})
        .catchError((onError) {});

    FirebaseFirestore.instance
        .collection('ExamSchedule')
        .doc(id)
        .set(ExampleScheduleResponse(
          id: id,
          timeStart: state.timeStartTextController.text,
          timeEnd: state.timeEndTextController.text,
          subjectId: state.subjectSelected.value.id,
          idClass: state.classSelected.value.id,
          idLecturers: [],
          title: state.titleTextController.text,
          description: state.locationTextController.text,
          dayStart: dayCreate.toString(),
          timeCreate: DateTime.now().toString(),
        ).toJson())
        .then((value) {
      Get.back(closeOverlays: true);
      AppSnackBar.showSuccess(
          title: 'Success', message: 'Create exam schedule success');
    }).catchError((onError) {
      AppSnackBar.showError(
          title: 'Error', message: 'Create exam schedule failure');
    });
  }

  void fetchData() {
    state.mergeRequest.listen((p0) {
      if (p0 <= 0) {}
    });

    state.mergeRequest.value++;
    FirebaseFirestore.instance.collection('Specialized').get().then((value) {
      state.listSpecialized.clear();
      value.docs.map((e) {
        var response = SpecializedResponse.fromJson(e.data());
        state.listSpecialized.add(response);
      }).toList();
      state.mergeRequest.value--;
    }).catchError((onError) {
      state.mergeRequest.value--;
    });

    state.mergeRequest.value++;
    FirebaseFirestore.instance.collection('Classs').get().then((value) {
      state.listClassResponse.clear();
      value.docs.map((e) {
        var response = ClassResponse.fromJson(e.data());
        state.listClassResponse.add(response);
      }).toList();
      state.mergeRequest.value--;
    }).catchError((onError) {
      state.mergeRequest.value--;
    });

    state.mergeRequest.value++;
    FirebaseFirestore.instance.collection('Subject').get().then((value) {
      state.listSubject.clear();
      value.docs.map((e) {
        var response = SubjectResponse.fromJson(e.data());
        state.listSubject.add(response);
      }).toList();
      state.mergeRequest.value--;
    }).catchError((onError) {
      state.mergeRequest.value--;
    });

    state.listTypeExam.add(TypeExamEntity(name: '15 minutes'));
    state.listTypeExam.add(TypeExamEntity(name: '30 minutes'));
    state.listTypeExam.add(TypeExamEntity(name: 'Mid-term test'));
    state.listTypeExam.add(TypeExamEntity(name: 'Final Exam'));
  }

  void checkSpecializedSelected(String id) {
    for (int i = 0; i < state.listSpecialized.length; i++) {
      if (state.listSpecialized[i].displayName == id) {
        state.specializedSelected.value = state.listSpecialized[i];
        // state.nameSpecializedTextController.text =
        //     state.specializedSelected.value.id ?? '';
      }
    }
  }

  void checkClassSelected(String value) {
    for (int i = 0; i < state.listClassResponse.length; i++) {
      if (state.listClassResponse[i].name == value) {
        state.classSelected.value = state.listClassResponse[i];
        // state.nameSpecializedTextController.text =
        //     state.specializedSelected.value.id ?? '';
      }
    }
  }

  void checkSubjectSelected(String value) {
    for (int i = 0; i < state.listSubject.length; i++) {
      if (state.listSubject[i].name == value) {
        state.subjectSelected.value = state.listSubject[i];
        // state.nameSpecializedTextController.text =
        //     state.specializedSelected.value.id ?? '';
      }
    }
  }

  void checkTypeExamSelected(String value) {
    for (int i = 0; i < state.listTypeExam.length; i++) {
      if (state.listTypeExam[i].name == value) {
        state.typeExamSelected.value = state.listTypeExam[i];
        // state.nameSpecializedTextController.text =
        //     state.specializedSelected.value.id ?? '';
      }
    }
  }
}
