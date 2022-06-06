import 'package:json_annotation/json_annotation.dart';

part 'department_response.g.dart';

@JsonSerializable()
class DepartmentResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'idBuilding')
  String? idBuilding;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'location')
  String? location;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'status')
  bool? status;
  String? nameBuilding;
  List<String>? idHistory;
  String? idOrder;

  DepartmentResponse({
    this.id,
    this.idBuilding,
    this.description,
    this.location,
    this.name,
    this.status,
    this.idHistory,
    this.idOrder,
  });

  factory DepartmentResponse.fromJson(Map<String, dynamic> json) =>
      _$DepartmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentResponseToJson(this);
}
