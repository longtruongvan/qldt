import 'package:json_annotation/json_annotation.dart';
part 'subject_response.g.dart';

@JsonSerializable()
class SubjectResponse {
  String? id;
  String? idSpecialized;
  String? name;
  String? code;
  int? numberOffLesson;
  String? icon;
  bool? isSelected;

  SubjectResponse({
    this.id,
    this.idSpecialized,
    this.name,
    this.code,
    this.numberOffLesson,
  });

  factory SubjectResponse.fromJson(Map<String, dynamic> json) =>
      _$SubjectResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectResponseToJson(this);
}
