// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_schedule_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExampleScheduleResponse _$ExampleScheduleResponseFromJson(
        Map<String, dynamic> json) =>
    ExampleScheduleResponse(
      id: json['id'] as String?,
      timeStart: json['timeStart'] as String?,
      timeEnd: json['timeEnd'] as String?,
      subjectId: json['subjectId'] as String?,
      idClass: json['idClass'] as String?,
      idLecturers: (json['idLecturers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      dayStart: json['dayStart'] as String?,
      timeCreate: json['timeCreate'] as String?,
    );

Map<String, dynamic> _$ExampleScheduleResponseToJson(
        ExampleScheduleResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timeStart': instance.timeStart,
      'timeEnd': instance.timeEnd,
      'subjectId': instance.subjectId,
      'idClass': instance.idClass,
      'idLecturers': instance.idLecturers,
      'title': instance.title,
      'description': instance.description,
      'dayStart': instance.dayStart,
      'timeCreate': instance.timeCreate,
    };
