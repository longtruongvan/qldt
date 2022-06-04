import 'package:qldt/model/response/person_response.dart';
import 'package:qldt/model/response/tuition_response.dart';

class TuitionEntity {
  final TuitionResponse tuitionResponse;
  final PersonResponse personResponse;

  const TuitionEntity({
    required this.tuitionResponse,
    required this.personResponse,
  });
}
