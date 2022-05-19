// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectResponse _$SubjectResponseFromJson(Map<String, dynamic> json) =>
    SubjectResponse(
      id: json['id'] as String?,
      idSpecialized: json['idSpecialized'] as String?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      numberOffLesson: json['numberOffLesson'] as int?,
    )
      ..icon = json['icon'] as String?
      ..isSelected = json['isSelected'] as bool?;

Map<String, dynamic> _$SubjectResponseToJson(SubjectResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idSpecialized': instance.idSpecialized,
      'name': instance.name,
      'code': instance.code,
      'numberOffLesson': instance.numberOffLesson,
      'icon': instance.icon,
      'isSelected': instance.isSelected,
    };
