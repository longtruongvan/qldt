// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassResponse _$ClassResponseFromJson(Map<String, dynamic> json) =>
    ClassResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      countMember: json['countMember'] as int?,
      specializedID: json['specializedID'] as String?,
      idStudent: (json['idStudent'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ClassResponseToJson(ClassResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'countMember': instance.countMember,
      'specializedID': instance.specializedID,
      'idStudent': instance.idStudent,
    };
