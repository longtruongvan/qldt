import 'package:json_annotation/json_annotation.dart';
part 'notification_response.g.dart';

@JsonSerializable()
class NotificationResponse {
  String? id;
  String? idExamSchedule;
  String? title;
  String? time;

  NotificationResponse({
    this.id,
    this.idExamSchedule,
    this.title,
    this.time,
  });

  factory NotificationResponse.fromJson(Map<String,dynamic> json) => _$NotificationResponseFromJson(json);

  Map<String,dynamic> toJson() => _$NotificationResponseToJson(this);
}
