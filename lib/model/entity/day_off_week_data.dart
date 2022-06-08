import 'package:json_annotation/json_annotation.dart';

part 'day_off_week_data.g.dart';
@JsonSerializable()
class DayOffWeekData {
  String? day;
  String? lesson;

  DayOffWeekData({this.day, this.lesson});

  factory DayOffWeekData.fromJson(Map<String, dynamic> json) =>
      _$DayOffWeekDataFromJson(json);

  Map<String, dynamic> toJson() => _$DayOffWeekDataToJson(this);
}
