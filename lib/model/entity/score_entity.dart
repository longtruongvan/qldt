import 'package:qldt/model/response/person_response.dart';

import '../response/score_response.dart';

class ScoreEntity {
  PersonResponse? personResponse;
  List<ScoreResponse>? listScore;

  ScoreEntity({
    this.personResponse,
    this.listScore,
  });
}
