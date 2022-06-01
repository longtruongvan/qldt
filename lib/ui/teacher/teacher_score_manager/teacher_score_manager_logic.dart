import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/response/class_response.dart';
import 'package:qldt/model/response/person_response.dart';
import 'package:qldt/model/response/specialized_response.dart';
import 'package:qldt/ui/teacher/teacher_score_manager/teacher_score_manager_state.dart';
import 'package:qldt/ui/teacher/teacher_score_manager/view_score/view_score_page.dart';

class TeacherScoreManagerLogic {
  final state = TeacherScoreManagerState();

  TeacherScoreManagerLogic() {
    fetchData();
  }

  void clickButtonNextHandler() {
    if (!state.spec1Active.value && !state.spec2Active.value) {
      return;
    }
    Get.to(ViewScorePage(
      students: state.listPersonResponse,
    ));
  }

  void clearHandler() {
    state.spec1Active.value = false;
    state.spec2Active.value = false;
    state.spec3Active.value = false;

    state.specializedSelected.value = SpecializedResponse();
    state.listSpecialized.clear();
    state.listSpecialized.addAll(state.currentListSpecialized);

    state.classResponseSelected.value = ClassResponse();
    state.listClassResponse.clear();
    state.listClassResponse.addAll(state.currentListClassResponse);

    state.personResponseSelected.value = PersonResponse();
    state.listPersonResponse.clear();
    state.listPersonResponse.addAll(state.currentListPersonResponse);
  }

  void checkPersonSelected(String id) {
    for (int i = 0; i < state.currentListPersonResponse.length; i++) {
      if (state.currentListPersonResponse[i].name == id) {
        state.personResponseSelected.value = state.currentListPersonResponse[i];
        // state.nameSpecializedTextController.text =
        //     state.specializedSelected.value.id ?? '';
      }
    }
    state.spec3Active.value = true;
  }

  void checkClassSelected(String id) {
    for (int i = 0; i < state.currentListClassResponse.length; i++) {
      if (state.currentListClassResponse[i].name == id) {
        state.classResponseSelected.value = state.currentListClassResponse[i];
        // state.nameSpecializedTextController.text =
        //     state.specializedSelected.value.id ?? '';
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
          title: 'Error', message: 'Get data specialized failure');
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
      AppSnackBar.showError(title: 'Error', message: 'Get data class failure');
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
          title: 'Error', message: 'Get data student failure');
    });
  }
}
