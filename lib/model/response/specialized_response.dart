import 'package:json_annotation/json_annotation.dart';
part 'specialized_response.g.dart';

@JsonSerializable()
class SpecializedResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'displayName')
  String? displayName;
  String? icon;
  String? code;

  SpecializedResponse({
    this.id,
    this.name,
    this.displayName,
    this.code,
  });

  factory SpecializedResponse.fromJson(Map<String, dynamic> json) =>
      _$SpecializedResponseFromJson(json);

  Map<String,dynamic> toJson() => _$SpecializedResponseToJson(this);
}
