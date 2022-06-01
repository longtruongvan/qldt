import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/entity/score_entity.dart';
import 'package:qldt/model/response/score_response.dart';
import 'package:qldt/model/response/subject_response.dart';
import 'package:qldt/services/auth_service.dart';
import 'package:qldt/ui/teacher/teacher_score_manager/view_score/view_score_state.dart';

import '../../../../model/response/person_response.dart';

class ViewScoreLogic {
  final state = ViewScoreState();
  final authService = Get.find<AuthService>();

  ViewScoreLogic() {}

  void fetchData(List<PersonResponse> persons) {
    state.statusLoading.value = true;
    state.mergeRequest.listen((value) {
      if (value <= 0) {
        state.statusLoading.value = false;
        for (int i = 0; i < state.listAllSubjectResponse.length; i++) {}
      }
    });

    /// Get subject
    state.mergeRequest++;
    FirebaseFirestore.instance.collection('Subject').get().then((value) {
      state.listAllSubjectResponse.clear();
      state.listSubjectWithSpecialized.clear();
      value.docs.map((e) {
        var response = SubjectResponse.fromJson(e.data());
        state.listAllSubjectResponse.add(response);
        if (response.idSpecialized == persons.first.idSpecialized) {
          state.listAllSubjectResponse.add(response);
        }
      }).toList();
      state.mergeRequest--;
    }).catchError((onError) {
      state.mergeRequest--;
      AppSnackBar.showError(title: 'Error', message: 'Get subject failure');
    });

    /// Get
    state.mergeRequest++;
    state.listScoreEntity.clear();
    for (int u = 0; u < persons.length; u++) {
      var listScore = <ScoreResponse>[];
      for(int k =0 ;k<(persons[u].idScores ?? []).length;k++){
        getScoreById(persons[u].idScores![k], (value) {
          listScore.add(value);
        });
      }
      state.listScoreEntity.add(ScoreEntity(
        personResponse: persons[u],
        listScore: listScore,
      ));
      state.mergeRequest--;
    }
  }

  void getScoreById(String idScore, Function(ScoreResponse) callback) {
    FirebaseFirestore.instance
        .collection('Score')
        .doc(idScore)
        .get()
        .then((value) {
      var response = ScoreResponse.fromJson(value.data() ?? {});
      if (value.data() != null) {
        callback(response);
      }
    }).onError((error, stackTrace) {

    });
  }
}
