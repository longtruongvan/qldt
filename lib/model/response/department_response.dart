import 'package:json_annotation/json_annotation.dart';

part 'department_response.g.dart';

@JsonSerializable()
class DepartmentResponse {
  String? id;
  String? idBuilding;
  String? description;
  String? location;
  String? name;
  bool? status;

  DepartmentResponse({
    this.id,
    this.idBuilding,
    this.description,
    this.location,
    this.name,
    this.status,
  });

  factory DepartmentResponse.fromJson(Map<String, dynamic> json) =>
      _$DepartmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentResponseToJson(this);
}
