// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreResponse _$ScoreResponseFromJson(Map<String, dynamic> json) =>
    ScoreResponse(
      id: json['id'] as String?,
      idStudent: json['idStudent'] as String?,
      idSubject: json['idSubject'] as String?,
      scoreNumber: json['scoreNumber'] as String?,
      typeScore: json['typeScore'] as int?,
      diligence: (json['diligence'] as num?)?.toDouble(),
      test: (json['test'] as num?)?.toDouble(),
      exam: (json['exam'] as num?)?.toDouble(),
      endOfCourse: (json['endOfCourse'] as num?)?.toDouble(),
      letter: json['letter'] as String?,
      evaluate: json['evaluate'] as String?,
    );

Map<String, dynamic> _$ScoreResponseToJson(ScoreResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idStudent': instance.idStudent,
      'idSubject': instance.idSubject,
      'scoreNumber': instance.scoreNumber,
      'typeScore': instance.typeScore,
      'diligence': instance.diligence,
      'test': instance.test,
      'exam': instance.exam,
      'endOfCourse': instance.endOfCourse,
      'letter': instance.letter,
      'evaluate': instance.evaluate,
    };
