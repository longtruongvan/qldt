// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialized_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecializedResponse _$SpecializedResponseFromJson(Map<String, dynamic> json) =>
    SpecializedResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      displayName: json['displayName'] as String?,
      code: json['code'] as String?,
    )..icon = json['icon'] as String?;

Map<String, dynamic> _$SpecializedResponseToJson(
        SpecializedResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'displayName': instance.displayName,
      'code': instance.code,
    };
