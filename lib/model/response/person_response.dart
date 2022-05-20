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

  PersonResponse({
    this.id,
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.type,
    this.location,
  });

  factory PersonResponse.fromJson(Map<String, dynamic> json) =>
      _$PersonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PersonResponseToJson(this);
}
