import 'package:json_annotation/json_annotation.dart';

part 'building_response.g.dart';

@JsonSerializable()
class BuildingResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  bool? isSelected;

  BuildingResponse({
    this.id,
    this.name,
    this.isSelected,
  });

  factory BuildingResponse.fromJson(Map<String, dynamic> json) =>
      _$BuildingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BuildingResponseToJson(this);
}
