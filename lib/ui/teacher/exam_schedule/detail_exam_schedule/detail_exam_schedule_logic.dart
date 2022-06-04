import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/entity/detail_exam_entity.dart';
import 'package:qldt/model/response/class_response.dart';
import 'package:qldt/model/response/example_schedule_response.dart';
import 'package:qldt/model/response/subject_response.dart';
import 'package:qldt/ui/teacher/exam_schedule/detail_exam_schedule/detail_exam_schedule_state.dart';

class DetailExamScheduleLogic extends GetxController {
  final state = DetailExamScheduleState();

  void fetchData(ExampleScheduleResponse response) {
    // DateTime now = DateTime.parse(response.dayStart??DateTime.now().toString());
    // String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    state.detailExamEntity.value = DetailExamEntity(
      exampleScheduleResponse: response,
    );

    state.mergeRequest.value++;
    state.mergeRequest.value++;
    state.mergeRequest.listen((p0) {
      if (p0 <= 0) {
        //update ui
        state.detailExamEntity.refresh();
      }
    });

    getClassById(response.idClass ?? '', (value) {
      state.mergeRequest.value--;
      if (value != null) {
        state.detailExamEntity.value.classResponse = value;
      }
    });

    getSubjectById(response.subjectId ?? '', (value) {
      state.mergeRequest.value--;
      if (value != null) {
        state.detailExamEntity.value.subjectResponse = value;
      }
    });
  }

  void getClassById(String id, Function(ClassResponse?) callback) {
    FirebaseFirestore.instance.collection('Classs').doc(id).get().then((value) {
      if (value.data() != null) {
        callback(ClassResponse.fromJson(value.data()!));
      } else {
        callback(null);
      }
    }).catchError((onError) {
      AppSnackBar.showError(
          title: 'Error', message: 'Get info subject failure');
      callback(null);
    });
  }

  void getSubjectById(String id, Function(SubjectResponse?) callback) {
    FirebaseFirestore.instance
        .collection('Subject')
        .doc(id)
        .get()
        .then((value) {
      if (value.data() != null) {
        callback(SubjectResponse.fromJson(value.data()!));
      } else {
        callback(null);
      }
    }).catchError((onError) {
      AppSnackBar.showError(
          title: 'Error', message: 'Get info subject failure');
      callback(null);
    });
  }
}
