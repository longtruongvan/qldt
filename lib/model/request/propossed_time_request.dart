import 'package:json_annotation/json_annotation.dart';

part 'propossed_time_request.g.dart';

@JsonSerializable()
class PropossedTimeRequest {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'dayOfWeek')
  List<String>? dayOfWeek;
  @JsonKey(name: 'period')
  String? period; // ex: tiết học 6
  @JsonKey(name: 'numberOfPeriod')
  String? numberOfPeriod; //  ex: hoc 3 tiet 6,7,8

  PropossedTimeRequest({
    this.id,
    this.dayOfWeek,
    this.period,
    this.numberOfPeriod,
  });

  factory PropossedTimeRequest.fromJson(Map<String, dynamic> json) =>
      _$PropossedTimeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PropossedTimeRequestToJson(this);
}
