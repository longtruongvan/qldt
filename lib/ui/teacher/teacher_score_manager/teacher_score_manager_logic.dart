import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/response/class_response.dart';
import 'package:qldt/model/response/person_response.dart';
import 'package:qldt/model/response/specialized_response.dart';
import 'package:qldt/model/response/subject_response.dart';
import 'package:qldt/ui/teacher/teacher_score_manager/teacher_score_manager_page.dart';
import 'package:qldt/ui/teacher/teacher_score_manager/teacher_score_manager_state.dart';
import 'package:qldt/ui/teacher/teacher_score_manager/view_score/view_score_page.dart';

import '../../../generated/l10n.dart';

class TeacherScoreManagerLogic {
  final state = TeacherScoreManagerState();

  TeacherScoreManagerLogic() {
    fetchData();
  }

  void checkSemester(String value) {
    int index = state.listSemester.indexWhere((element) => element == value);
    if (index <= 0) {
      return;
    }
    state.semesterPositionSelected.value = index;
  }

  void checkTimeSchoolYear(String value) {
    state.yearSchoolSelected.value = value;
    state.semesterPositionSelected.value = 0;
  }

  void clickButtonNextHandler(TypeScoreManager typeScoreManager) {
    if (!state.spec1Active.value ||
        !state.spec2Active.value ||
        !state.spec4Active.value) {
      return;
    }
    List<PersonResponse> p = [];
    if(state.personResponseSelected.value.id!=null){
      p.add(state.personResponseSelected.value);
    }else{
      p.addAll(state.listPersonResponse);
    }
    Get.to(ViewScorePage(
      students: p,
      currentListStudent: state.currentListPersonResponse,
      typeScoreManager: typeScoreManager,
      viewType: (state.yearSchoolSelected.value == S.current.common_all)
          ? ScoreViewType.all
          : ScoreViewType.subject,
      subjectResponse: state.subjectResponseSelected.value,
    ));
  }

  void clearHandler() {
    state.spec1Active.value = false;
    state.spec2Active.value = false;
    state.spec3Active.value = false;
    state.spec4Active.value = false;

    state.specializedSelected.value = SpecializedResponse();
    state.listSpecialized.clear();
    state.listSpecialized.addAll(state.currentListSpecialized);

    state.classResponseSelected.value = ClassResponse();
    state.listClassResponse.clear();
    state.listClassResponse.addAll(state.currentListClassResponse);

    state.yearSchoolSelected.value = S.current.common_all;
    state.yearSchool.clear();

    state.personResponseSelected.value = PersonResponse();
    state.listPersonResponse.clear();
    state.listPersonResponse.addAll(state.currentListPersonResponse);

    state.subjectResponseSelected.value = SubjectResponse();
    state.listSubjectResponse.clear();
    state.listSubjectResponse.addAll(state.currentListSubjectResponse);
  }

  void checkSubjectSelected(String value){
    for (int i = 0; i < state.currentListSubjectResponse.length; i++) {
      if (state.currentListSubjectResponse[i].name == value) {
        state.subjectResponseSelected.value = state.currentListSubjectResponse[i];
      }
    }
    state.spec3Active.value = true;
    state.spec4Active.value = true;
  }

  void checkPersonSelected(String id) {
    for (int i = 0; i < state.currentListPersonResponse.length; i++) {
      if (state.currentListPersonResponse[i].name == id) {
        state.personResponseSelected.value = state.currentListPersonResponse[i];
      }
    }
    state.spec3Active.value = true;
  }

  void checkClassSelected(String id) {
    state.personResponseSelected.value = PersonResponse();
    for (int i = 0; i < state.currentListClassResponse.length; i++) {
      if (state.currentListClassResponse[i].name == id) {
        state.classResponseSelected.value = state.currentListClassResponse[i];
        state.yearSchool.clear();
        state.yearSchoolSelected.value = S.current.common_all;
        state.yearSchool
            .addAll(state.currentListClassResponse[i].schoolYear ?? []);
      }
    }
    // map data student to class
    state.listPersonResponse.clear();
    for (int i = 0; i < state.currentListPersonResponse.length; i++) {
      if (state.currentListPersonResponse[i].idClass ==
          state.classResponseSelected.value.id) {
        state.listPersonResponse.add(state.currentListPersonResponse[i]);
      }
    }
    state.spec2Active.value = true;
  }

  void checkSpecializedSelected(String id) {
    state.personResponseSelected.value = PersonResponse();
    state.classResponseSelected.value = ClassResponse();
    state.yearSchoolSelected.value = S.current.common_all;
    state.yearSchool.clear();
    state.spec2Active.value = false;
    state.spec3Active.value = false;
    state.spec4Active.value = false;

    state.listClassResponse.clear();
    for (int i = 0; i < state.currentListSpecialized.length; i++) {
      if (state.currentListSpecialized[i].displayName == id) {
        state.specializedSelected.value = state.currentListSpecialized[i];
        // state.nameSpecializedTextController.text =
        //     state.specializedSelected.value.id ?? '';
      }
    }

    // map data class to specialized
    state.listClassResponse.clear();
    for (int i = 0; i < state.currentListClassResponse.length; i++) {
      if (state.currentListClassResponse[i].specializedID ==
          state.specializedSelected.value.id) {
        state.listClassResponse.add(state.currentListClassResponse[i]);
      }
    }

    state.spec1Active.value = true;
    state.listSubjectResponse.clear();
    state.subjectResponseSelected.value = SubjectResponse();
    for(int i=0;i<state.currentListSubjectResponse.length;i++){
      if(state.currentListSubjectResponse[i].idSpecialized==state.specializedSelected.value.id){
        state.listSubjectResponse.add(state.currentListSubjectResponse[i]);
      }
    }
  }

  void fetchData() {
    // Get Specialized
    FirebaseFirestore.instance.collection('Specialized').get().then((value) {
      state.currentListSpecialized.clear();
      state.listSpecialized.clear();
      value.docs.map((e) {
        var response = SpecializedResponse.fromJson(e.data());
        state.currentListSpecialized.add(response);
        state.listSpecialized.add(response);
      }).toList();
    }).catchError((onError) {
      AppSnackBar.showError(
          title: S.current.common_error, message: S.current.getDataSpecializedFailure);
    });

    // Get Class
    FirebaseFirestore.instance.collection('Classs').get().then((value) {
      state.currentListClassResponse.clear();
      state.listClassResponse.clear();
      value.docs.map((e) {
        var response = ClassResponse.fromJson(e.data());
        state.currentListClassResponse.add(response);
        state.listClassResponse.add(response);
      }).toList();
    }).catchError((onError) {
      AppSnackBar.showError(title: S.current.common_error, message: S.current.getDataClassFailure);
    });

    // Get Person
    FirebaseFirestore.instance.collection('Person').get().then((value) {
      state.currentListPersonResponse.clear();
      state.listPersonResponse.clear();
      value.docs.map((e) {
        var response = PersonResponse.fromJson(e.data());
        state.currentListPersonResponse.add(response);
        state.listPersonResponse.add(response);
      }).toList();
    }).catchError((onError) {
      AppSnackBar.showError(
          title: S.current.common_error, message: S.current.getDataStudentFailure);
    });

    // Get subject
    FirebaseFirestore.instance.collection('Subject').get().then((value) {
      state.currentListSubjectResponse.clear();
      state.listSubjectResponse.clear();
      value.docs.map((e) {
        var response = SubjectResponse.fromJson(e.data());
        state.currentListSubjectResponse.add(response);
        state.listSubjectResponse.add(response);
      }).toList();
    }).catchError((onError) {
      AppSnackBar.showError(
          title: S.current.common_error, message: S.current.getDataSubjectFailure);
    });
  }
}
