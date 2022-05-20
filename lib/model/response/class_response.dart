import 'package:json_annotation/json_annotation.dart';
part 'class_response.g.dart';
@JsonSerializable()
class ClassResponse {
  String? id;
  String? name;
  String? code;
  int? countMember;
  String? specializedID;
  List<String>? idStudent;

  ClassResponse({
    this.id,
    this.name,
    this.code,
    this.countMember,
    this.specializedID,
    this.idStudent,
  });

  factory ClassResponse.fromJson(Map<String, dynamic> json) =>
      _$ClassResponseFromJson(json);

  Map<String,dynamic> toJson() => _$ClassResponseToJson(this);
}
