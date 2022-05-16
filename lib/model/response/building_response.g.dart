// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildingResponse _$BuildingResponseFromJson(Map<String, dynamic> json) =>
    BuildingResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      isSelected: json['isSelected'] as bool?,
    );

Map<String, dynamic> _$BuildingResponseToJson(BuildingResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isSelected': instance.isSelected,
    };
