import 'package:json_annotation/json_annotation.dart';
part 'department_history_response.g.dart';

@JsonSerializable()
class DepartmentHistoryResponse {
  String? id;
  String? idOrder;
  String? idDepartment;
  String? avatarUrl;
  String? timeOrder;
  String? title;
  String? timeFormat;

  DepartmentHistoryResponse({
    this.id,
    this.idOrder,
    this.idDepartment,
    this.avatarUrl,
    this.timeOrder,
    this.title,
  });

  factory DepartmentHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$DepartmentHistoryResponseFromJson(json);

  Map<String,dynamic> toJson() => _$DepartmentHistoryResponseToJson(this);
}
