import 'package:json_annotation/json_annotation.dart';
part 'specialized_response.g.dart';

@JsonSerializable()
class SpecializedResponse {
  String? id;
  String? name;
  String? displayName;
  String? icon;

  SpecializedResponse({
    this.id,
    this.name,
    this.displayName,
  });

  factory SpecializedResponse.fromJson(Map<String, dynamic> json) =>
      _$SpecializedResponseFromJson(json);

  Map<String,dynamic> toJson() => _$SpecializedResponseToJson(this);
}