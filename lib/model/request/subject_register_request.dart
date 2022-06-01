import 'package:json_annotation/json_annotation.dart';
import 'package:qldt/model/request/propossed_time_request.dart';

part 'subject_register_request.g.dart';

@JsonSerializable()
class SubjectRegisterRequest {
  String? id;
  String? idSender;
  String? idSpecialized;
  String? timeRequest;
  String? timePayment;
  String? subjectIds;
  @JsonKey(name: 'propossedTime')
  PropossedTimeRequest? propossedTime;
  bool? isAccept;

  SubjectRegisterRequest({
    this.id,
    this.idSender,
    this.idSpecialized,
    this.timeRequest,
    this.timePayment,
    this.subjectIds,
    this.propossedTime,
    this.isAccept,
  });

  factory SubjectRegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$SubjectRegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectRegisterRequestToJson(this);
}
