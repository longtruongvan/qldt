import 'package:qldt/model/request/subject_register_request.dart';
import 'package:qldt/model/response/tuition_response.dart';

class TuitionEntity {
  final TuitionResponse tuitionResponse;
  final SubjectRegisterRequest courseResponse;

  const TuitionEntity({
    required this.tuitionResponse,
    required this.courseResponse,
  });
}
