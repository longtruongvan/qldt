// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentResponse _$DepartmentResponseFromJson(Map<String, dynamic> json) =>
    DepartmentResponse(
      id: json['id'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      name: json['name'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$DepartmentResponseToJson(DepartmentResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'location': instance.location,
      'name': instance.name,
      'status': instance.status,
    };
