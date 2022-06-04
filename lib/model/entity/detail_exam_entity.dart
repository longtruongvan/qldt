import 'package:qldt/model/response/class_response.dart';
import 'package:qldt/model/response/example_schedule_response.dart';
import 'package:qldt/model/response/subject_response.dart';

class DetailExamEntity {
  ExampleScheduleResponse? exampleScheduleResponse;
  SubjectResponse? subjectResponse;
  ClassResponse? classResponse;
  String? timeFormat;

  DetailExamEntity({
    this.exampleScheduleResponse,
    this.subjectResponse,
    this.classResponse,
    this.timeFormat,
  });
}
