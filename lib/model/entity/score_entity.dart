import 'package:flutter/material.dart';
import 'package:qldt/model/response/person_response.dart';

import '../response/score_response.dart';

class ScoreEntity {
  PersonResponse? personResponse;
  List<ScoreResponse>? listScore;
  bool? isEdit;
  TextEditingController? diligenceTextController;
  TextEditingController? testTextController;
  TextEditingController? examTextController;
  TextEditingController? endOfCourseTextController;
  TextEditingController? letterTextController;
  TextEditingController? evaluateTextController;

  ScoreEntity({
    this.personResponse,
    this.listScore,
    this.isEdit,
    this.diligenceTextController,
    this.testTextController,
    this.examTextController,
    this.endOfCourseTextController,
    this.letterTextController,
    this.evaluateTextController,
  });
}
