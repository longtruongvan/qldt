import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/generated/l10n.dart';
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
        DateTime now = DateTime.parse(response.dayStart??DateTime.now().toString());
        String formattedDate = DateFormat('dd-MM-yyyy').format(now);
        response.dayStart = formattedDate;
        state.listExamSchedule.add(response);
      }).toList();
      state.mergeRequest.value--;
    }).catchError((onError) {
      state.mergeRequest.value--;
      AppSnackBar.showError(title: S.current.common_error, message: S.current.common_fetch_data_failure);
    });
  }
}
