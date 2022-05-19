// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentResponse _$DepartmentResponseFromJson(Map<String, dynamic> json) =>
    DepartmentResponse(
      id: json['id'] as String?,
      idBuilding: json['idBuilding'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      name: json['name'] as String?,
      status: json['status'] as bool?,
    )..nameBuilding = json['nameBuilding'] as String?;

Map<String, dynamic> _$DepartmentResponseToJson(DepartmentResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idBuilding': instance.idBuilding,
      'description': instance.description,
      'location': instance.location,
      'name': instance.name,
      'status': instance.status,
      'nameBuilding': instance.nameBuilding,
    };
