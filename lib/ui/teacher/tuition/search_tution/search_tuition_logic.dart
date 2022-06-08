import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/ui/teacher/tuition/search_tution/search_tuition_state.dart';
import 'package:qldt/ui/teacher/tuition/tuition_state.dart';

import '../../../../common/app_snack_bar.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/response/class_response.dart';
import '../../../../model/response/person_response.dart';
import '../../../../model/response/specialized_response.dart';

class SearchTuitionLogic extends GetxController{
  final state = SearchTuitionState();

  SearchTuitionLogic(){
    fetchData();
  }

  void checkPersonSelected(String id) {
    for (int i = 0; i < state.currentListPersonResponse.length; i++) {
      if (state.currentListPersonResponse[i].name == id) {
        state.personResponseSelected.value = state.currentListPersonResponse[i];
      }
    }
  }

  void checkClassSelected(String id) {
    state.personResponseSelected.value = PersonResponse();
    for (int i = 0; i < state.currentListClassResponse.length; i++) {
      if (state.currentListClassResponse[i].name == id) {
        state.classResponseSelected.value = state.currentListClassResponse[i];
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
  }

  void checkSpecializedSelected(String id) {
    state.personResponseSelected.value = PersonResponse();
    state.classResponseSelected.value = ClassResponse();

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
          title:  S.current.common_error, message: S.current.getDataStudentFailure);
    });
  }
}