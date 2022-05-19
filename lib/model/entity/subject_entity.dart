import 'package:flutter/material.dart';
import 'package:qldt/model/response/subject_response.dart';

import 'day_of_week_entity.dart';

class SubjectEntity {
  TextEditingController? numberOfPreiodTextController;
  TextEditingController? preiodStartTextController;
  SubjectResponse? subjectResponse;
  List<DayOffWeekEntity>? listDayOfWeek;

  SubjectEntity({
    this.numberOfPreiodTextController,
    this.preiodStartTextController,
    this.subjectResponse,
    this.listDayOfWeek,
  }) : super();
}
