// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonResponse _$PersonResponseFromJson(Map<String, dynamic> json) =>
    PersonResponse(
      id: json['id'] as String?,
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      type: json['type'] as String?,
      location: json['location'] as String?,
      idCourse: (json['idCourse'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      idClass: json['idClass'] as String?,
      idSpecialized: json['idSpecialized'] as String?,
      idScores: (json['idScores'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      code: json['code'] as String?,
      birthday: json['birthday'] as String?,
      idTuition: (json['idTuition'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$PersonResponseToJson(PersonResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'type': instance.type,
      'location': instance.location,
      'idCourse': instance.idCourse,
      'idClass': instance.idClass,
      'idSpecialized': instance.idSpecialized,
      'idScores': instance.idScores,
      'code': instance.code,
      'birthday': instance.birthday,
      'idTuition': instance.idTuition,
      'avatar': instance.avatar,
    };
