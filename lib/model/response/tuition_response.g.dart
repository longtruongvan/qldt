// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tuition_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TuitionResponse _$TuitionResponseFromJson(Map<String, dynamic> json) =>
    TuitionResponse(
      id: json['id'] as String?,
      idStudent: json['idStudent'] as String?,
      state: json['state'] as bool?,
      price: (json['price'] as num?)?.toDouble(),
      schoolYear: json['schoolYear'] as String?,
      semester: json['semester'] as String?,
      timePayment: json['timePayment'] as String?,
      method: json['method'] as String?,
    );

Map<String, dynamic> _$TuitionResponseToJson(TuitionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idStudent': instance.idStudent,
      'state': instance.state,
      'price': instance.price,
      'schoolYear': instance.schoolYear,
      'semester': instance.semester,
      'timePayment': instance.timePayment,
      'method': instance.method,
    };
