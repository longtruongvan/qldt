// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'propossed_time_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropossedTimeRequest _$PropossedTimeRequestFromJson(
        Map<String, dynamic> json) =>
    PropossedTimeRequest(
      id: json['id'] as String?,
      dayOfWeek: (json['dayOfWeek'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      period: json['period'] as String?,
      numberOfPeriod: json['numberOfPeriod'] as String?,
      dayOffWeekData: (json['dayOffWeekData'] as List<dynamic>?)
          ?.map((e) => DayOffWeekData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PropossedTimeRequestToJson(
        PropossedTimeRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dayOfWeek': instance.dayOfWeek,
      'period': instance.period,
      'numberOfPeriod': instance.numberOfPeriod,
      'dayOffWeekData': instance.dayOffWeekData?.map((e) => e.toJson()).toList(),
    };
