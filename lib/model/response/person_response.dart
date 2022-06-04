import 'package:json_annotation/json_annotation.dart';

part 'person_response.g.dart';

@JsonSerializable()
class PersonResponse {
  String? id;
  String? uid;
  String? name;
  String? email;
  String? phone;
  String? type;
  String? location;
  List<String>? idCourse;
  String? idClass;
  String? idSpecialized;
  List<String>? idScores;
  String? code;
  String? birthday;
  List<String>? idTuition;
  String? avatar;
  List<String>? idNotification;

  PersonResponse({
    this.id,
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.type,
    this.location,
    this.idCourse,
    this.idClass,
    this.idSpecialized,
    this.idScores,
    this.code,
    this.birthday,
    this.idTuition,
    this.avatar,
    this.idNotification,
  });

  factory PersonResponse.fromJson(Map<String, dynamic> json) =>
      _$PersonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PersonResponseToJson(this);
}
