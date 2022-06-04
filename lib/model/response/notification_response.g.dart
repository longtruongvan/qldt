// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponse _$NotificationResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationResponse(
      id: json['id'] as String?,
      idExamSchedule: json['idExamSchedule'] as String?,
      title: json['title'] as String?,
      time: json['time'] as String?,
      idSender: json['idSender'] as String?,
      idReceiver: json['idReceiver'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      typeNotification: json['typeNotification'] as String?,
      isRead: json['isRead'] as bool?,
    );

Map<String, dynamic> _$NotificationResponseToJson(
        NotificationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idExamSchedule': instance.idExamSchedule,
      'title': instance.title,
      'time': instance.time,
      'idSender': instance.idSender,
      'idReceiver': instance.idReceiver,
      'avatarUrl': instance.avatarUrl,
      'typeNotification': instance.typeNotification,
      'isRead': instance.isRead,
    };
