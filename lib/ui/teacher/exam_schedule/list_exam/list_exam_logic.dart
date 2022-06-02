import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/response/example_schedule_response.dart';
import 'package:qldt/ui/teacher/exam_schedule/list_exam/list_exam_state.dart';

class ListExamLogic extends GetxController {
  final state = ListExamState();

  ListExamLogic() {
    fetchData();
  }

  void fetchData() {
    state.mergeRequest.listen((p0) {
      if (p0 <= 0) {
        state.listExamSchedule.refresh();
      }
    });

    state.mergeRequest.value++;
    FirebaseFirestore.instance
        .collection('ExamSchedule')
        .orderBy('timeCreate', descending: true)
        .get()
        .then((value) {
      state.listExamSchedule.clear();
      value.docs.map((e) {
        var response = ExampleScheduleResponse.fromJson(e.data());
        state.listExamSchedule.add(response);
      }).toList();
      state.mergeRequest.value--;
    }).catchError((onError) {
      state.mergeRequest.value--;
      AppSnackBar.showError(title: 'Error', message: 'Fetch data error');
    });
  }
}
