import 'package:json_annotation/json_annotation.dart';

part 'propossed_time_request.g.dart';

@JsonSerializable()
class PropossedTimeRequest {
  String? id;
  List<String>? dayOfWeek;
  String? period; // ex: tiết học 6
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
