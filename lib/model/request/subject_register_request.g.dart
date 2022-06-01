// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectRegisterRequest _$SubjectRegisterRequestFromJson(
        Map<String, dynamic> json) =>
    SubjectRegisterRequest(
      id: json['id'] as String?,
      idSender: json['idSender'] as String?,
      idSpecialized: json['idSpecialized'] as String?,
      timeRequest: json['timeRequest'] as String?,
      timePayment: json['timePayment'] as String?,
      subjectIds: json['subjectIds'] as String?,
      propossedTime: json['propossedTime'] == null
          ? null
          : PropossedTimeRequest.fromJson(
              json['propossedTime'] as Map<String, dynamic>),
      isAccept: json['isAccept'] as bool?,
    );

Map<String, dynamic> _$SubjectRegisterRequestToJson(
        SubjectRegisterRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idSender': instance.idSender,
      'idSpecialized': instance.idSpecialized,
      'timeRequest': instance.timeRequest,
      'timePayment': instance.timePayment,
      'subjectIds': instance.subjectIds,
      'propossedTime': instance.propossedTime?.toJson(),
      'isAccept': instance.isAccept,
    };
