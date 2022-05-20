import 'package:get/get.dart';
import 'package:qldt/model/response/example_schedule_response.dart';

class ListExamState {
  RxInt mergeRequest = 0.obs;
  RxList<ExampleScheduleResponse> listExamSchedule =
      <ExampleScheduleResponse>[].obs;
}
