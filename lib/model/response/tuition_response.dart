import 'package:json_annotation/json_annotation.dart';
part 'tuition_response.g.dart';

@JsonSerializable()
class TuitionResponse {
  String? id;
  String? idStudent;
  bool? state;
  double? price;
  String? schoolYear; // ex: 2019-2020
  String? semester;
  String? timePayment;
  String? method;

  TuitionResponse({
    this.id,
    this.idStudent,
    this.state,
    this.price,
    this.schoolYear,
    this.semester,
    this.timePayment,
    this.method,
  });

  factory TuitionResponse.fromJson(Map<String, dynamic> json) =>
      _$TuitionResponseFromJson(json);

  Map<String,dynamic> toJson() => _$TuitionResponseToJson(this);
}
