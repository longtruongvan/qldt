import 'package:qldt/model/request/subject_register_request.dart';
import 'package:qldt/model/response/specialized_response.dart';
import 'package:qldt/model/response/subject_response.dart';

class CourseEntity {
  SubjectResponse? subjectResponse;
  SpecializedResponse? specializedResponse;
  SubjectRegisterRequest? subjectRegisterRequest;

  CourseEntity({
    this.specializedResponse,
    this.subjectRegisterRequest,
    this.subjectResponse,
  });
}
