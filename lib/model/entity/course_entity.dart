import 'package:qldt/model/request/subject_register_request.dart';
import 'package:qldt/model/response/person_response.dart';
import 'package:qldt/model/response/specialized_response.dart';
import 'package:qldt/model/response/subject_response.dart';

class CourseEntity {
  SubjectResponse? subjectResponse;
  PersonResponse? personResponse;
  List<PersonResponse>? listStudent;
  SpecializedResponse? specializedResponse;
  SubjectRegisterRequest? subjectRegisterRequest;
  String? image;
  bool isAdd = false;

  CourseEntity({
    this.specializedResponse,
    this.subjectRegisterRequest,
    this.subjectResponse,
    this.image,
    this.personResponse,
  });
}
