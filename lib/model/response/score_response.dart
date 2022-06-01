import 'package:json_annotation/json_annotation.dart';

part 'score_response.g.dart';

@JsonSerializable()
class ScoreResponse {
  String? id;
  String? idStudent;
  String? idSubject;
  String? scoreNumber;
  int? typeScore;
  double? diligence; // Điểm chuyên cần
  double? test; // Điểm kiểm tra giữa kỳ
  double? exam; // Điểm thi
  double? endOfCourse; // Điểm thi kết thúc
  String? letter; // Điểm chữ
  String? evaluate; // đánh giá: đạt hoặc không đạt

  ScoreResponse({
    this.id,
    this.idStudent,
    this.idSubject,
    this.scoreNumber,
    this.typeScore,
    this.diligence,
    this.test,
    this.exam,
    this.endOfCourse,
    this.letter,
    this.evaluate,
  });

  factory ScoreResponse.fromJson(Map<String, dynamic> json) =>
      _$ScoreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreResponseToJson(this);
}
