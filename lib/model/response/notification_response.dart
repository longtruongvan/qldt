import 'package:json_annotation/json_annotation.dart';

part 'notification_response.g.dart';

@JsonSerializable()
class NotificationResponse {
  String? id;
  String? idExamSchedule;
  String? title;
  String? time;
  String? idSender;
  String? avatarUrl;
  String? typeNotification; // hoc phi, lich thi,...

  NotificationResponse({
    this.id,
    this.idExamSchedule,
    this.title,
    this.time,
    this.idSender,
    this.avatarUrl,
    this.typeNotification,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}
