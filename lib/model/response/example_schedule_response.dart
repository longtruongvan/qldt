import 'package:json_annotation/json_annotation.dart';

part 'example_schedule_response.g.dart';

@JsonSerializable()
class ExampleScheduleResponse {
  String? id;
  String? timeStart;
  String? timeEnd;
  String? subjectId;
  String? idClass;
  List<String>? idLecturers;
  String? title;
  String? description;
  String? dayStart;

  ExampleScheduleResponse({
    this.id,
    this.timeStart,
    this.timeEnd,
    this.subjectId,
    this.idClass,
    this.idLecturers,
    this.title,
    this.description,
    this.dayStart,
  });

  factory ExampleScheduleResponse.fromJson(Map<String,dynamic> json) => _$ExampleScheduleResponseFromJson(json);

  Map<String,dynamic> toJson() => _$ExampleScheduleResponseToJson(this);
}
