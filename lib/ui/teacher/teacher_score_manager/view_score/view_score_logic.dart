import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/entity/score_entity.dart';
import 'package:qldt/model/response/score_response.dart';
import 'package:qldt/model/response/subject_response.dart';
import 'package:qldt/services/auth_service.dart';
import 'package:qldt/ui/teacher/teacher_score_manager/view_score/view_score_page.dart';
import 'package:qldt/ui/teacher/teacher_score_manager/view_score/view_score_state.dart';
import 'package:uuid/uuid.dart';

import '../../../../model/response/person_response.dart';

class ViewScoreLogic {
  final state = ViewScoreState();
  final authService = Get.find<AuthService>();

  ViewScoreLogic() {}

  void deleteScore(int index, Function() callback) {
    state.statusLoading.value = true;
    state.listScoreEntity[index].diligenceTextController?.text = '0.0';
    state.listScoreEntity[index].testTextController?.text = '0.0';
    state.listScoreEntity[index].examTextController?.text = '0.0';
    state.listScoreEntity[index].endOfCourseTextController?.text = '0.0';
    state.listScoreEntity[index].letterTextController?.text = 'F';
    state.listScoreEntity[index].evaluateTextController?.text = 'Chưa đạt';

    ScoreResponse? scoreResponse =
        state.listScoreEntity[index].listScore?.first;
    scoreResponse?.diligence = 0.0;

    scoreResponse?.test = 0.0;

    scoreResponse?.exam = 0.0;

    scoreResponse?.endOfCourse = 0.0;

    scoreResponse?.letter = 'F';

    scoreResponse?.evaluate = 'Chưa đạt';

    FirebaseFirestore.instance
        .collection('Score')
        .doc(scoreResponse?.id)
        .update(scoreResponse?.toJson() ?? {})
        .then((value) {
      state.listScoreEntity[index].listScore?.first = scoreResponse!;
      AppSnackBar.showSuccess(
          title: 'Success', message: 'Remove score success');
      state.statusLoading.value = false;
      state.listScoreEntity.refresh();
    }).catchError((onError) {
      AppSnackBar.showError(title: 'Error', message: 'Remove score failure');
      state.statusLoading.value = false;
    });
  }

  void updateScore(int index, Function() callback) {
    List<ScoreResponse> listScore = state.listScoreEntity[index].listScore??[];
    state.statusLoading.value = true;
    ScoreResponse scoreResponse =
        (listScore.isNotEmpty) ? listScore.first : ScoreResponse();
    scoreResponse.diligence = double.tryParse(
        state.listScoreEntity[index].diligenceTextController?.text ?? '');

    scoreResponse.test = double.tryParse(
        state.listScoreEntity[index].testTextController?.text ?? '');

    scoreResponse.exam = double.tryParse(
        state.listScoreEntity[index].examTextController?.text ?? '');

    scoreResponse.endOfCourse = double.tryParse(
        state.listScoreEntity[index].endOfCourseTextController?.text ?? '');

    scoreResponse.letter =
        state.listScoreEntity[index].letterTextController?.text;

    scoreResponse.evaluate =
        state.listScoreEntity[index].evaluateTextController?.text;

    if (scoreResponse.diligence == null ||
        scoreResponse.test == null ||
        scoreResponse.exam == null ||
        scoreResponse.endOfCourse == null ||
        scoreResponse.letter == null ||
        scoreResponse.evaluate == null) {
      state.statusLoading.value = false;
      AppSnackBar.showWarning(
          title: 'Warning', message: 'Please fill in all the information');
      return;
    }

    // if not exist
    if(!(state.listScoreEntity[index].isExist??false)){
      String id = const Uuid().v1();
      scoreResponse.idSubject = state.listScoreEntity[index].idSubject;
      scoreResponse.idStudent = state.listScoreEntity[index].idStudent;
      scoreResponse.id = id;

      //add data score to table score
      FirebaseFirestore.instance
          .collection('Score')
          .doc(id)
          .set(scoreResponse.toJson() ?? {})
          .then((value) {
        AppSnackBar.showSuccess(
            title: 'Success', message: 'Add score success');
        state.statusLoading.value = false;
        state.listScoreEntity.refresh();
        (state.listScoreEntity[index].listScore??[]).clear();
        (state.listScoreEntity[index].listScore??[]).add(scoreResponse);
        state.listScoreEntity[index].isExist = true;
        state.listScoreEntity.refresh();
      }).catchError((onError) {
        AppSnackBar.showError(title: 'Error', message: 'Add score failure');
        state.statusLoading.value = false;
      });

      // add id score to list score in table person
      FirebaseFirestore.instance
          .collection('Person')
          .doc(scoreResponse.idStudent)
          .update({
        'idScores':  FieldValue.arrayUnion([id])
      })
          .then((value) {
        // AppSnackBar.showSuccess(
        //     title: 'Success', message: 'Update score success');
      }).catchError((onError) {
        AppSnackBar.showError(title: 'Error', message: 'Update score failure');
      });
      return;
    }

    FirebaseFirestore.instance
        .collection('Score')
        .doc(scoreResponse.id)
        .update(scoreResponse.toJson() ?? {})
        .then((value) {
      AppSnackBar.showSuccess(
          title: 'Success', message: 'Update score success');
      state.statusLoading.value = false;
      state.listScoreEntity.refresh();
    }).catchError((onError) {
      AppSnackBar.showError(title: 'Error', message: 'Update score failure');
      state.statusLoading.value = false;
    });
  }

  void fetchData(List<PersonResponse> persons, ScoreViewType viewType,
      SubjectResponse subjectResponse) {
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
      RxInt dispatchGroup = 0.obs;
      var listScore = <ScoreResponse>[];
      dispatchGroup.listen((p0) {
        if (p0 <= 0) {
          if (persons[u].idScores != null) {
            state.listScoreEntity.add(ScoreEntity(
              personResponse: persons[u],
              listScore: listScore,
              isEdit: false,
              isExist: listScore.isNotEmpty,
              idSubject: subjectResponse.id,
              idStudent: persons[u].id,
              diligenceTextController: TextEditingController(
                text:
                    '${(listScore.isNotEmpty) ? listScore.first.diligence : ''}',
              ),
              testTextController: TextEditingController(
                text: '${(listScore.isNotEmpty) ? listScore.first.test : ''}',
              ),
              examTextController: TextEditingController(
                text: '${(listScore.isNotEmpty) ? listScore.first.exam : ''}',
              ),
              endOfCourseTextController: TextEditingController(
                text:
                    '${(listScore.isNotEmpty) ? listScore.first.endOfCourse : ''}',
              ),
              letterTextController: TextEditingController(
                text: '${(listScore.isNotEmpty) ? listScore.first.letter : ''}',
              ),
              evaluateTextController: TextEditingController(
                text:
                    '${(listScore.isNotEmpty) ? listScore.first.evaluate : ''}',
              ),
            ));
          }
        }
      });
      for (int k = 0; k < (persons[u].idScores ?? []).length; k++) {
        dispatchGroup.value++;
        getScoreById(persons[u].idScores![k], (value) {
          if (value.id != null && value.idSubject == subjectResponse.id) {
            listScore.add(value);
          }
          dispatchGroup.value--;
        });
      }
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
      callback(ScoreResponse());
    });
  }
}
