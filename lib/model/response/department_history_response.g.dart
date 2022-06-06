// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentHistoryResponse _$DepartmentHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    DepartmentHistoryResponse(
      id: json['id'] as String?,
      idOrder: json['idOrder'] as String?,
      idDepartment: json['idDepartment'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      timeOrder: json['timeOrder'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$DepartmentHistoryResponseToJson(
        DepartmentHistoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idOrder': instance.idOrder,
      'idDepartment': instance.idDepartment,
      'avatarUrl': instance.avatarUrl,
      'timeOrder': instance.timeOrder,
      'title': instance.title,
    };
