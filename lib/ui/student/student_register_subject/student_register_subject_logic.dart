import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/response/specialized_response.dart';
import 'package:qldt/model/response/subject_response.dart';
import 'package:qldt/ui/student/student_register_subject/student_register_subject_state.dart';

class StudentRegisterSubjectLogic {
  final state = StudentRegisterSubjectState();

  StudentRegisterSubjectLogic() {
    fetchData();
  }

  void selectSubject(int index) {
    state.listSubject[index].isSelected =
        !(state.listSubject[index].isSelected ?? false);
    state.listSubject.refresh();
    int position = state.currentListSubject
        .indexWhere((element) => element.id == state.listSubject[index].id);
    if (position >= 0) {
      // state.currentListSubject[position].isSelected =
      //     !state.currentListSubject[position].isSelected;
    }

    state.countSubjectSelected.value = 0;
    for (int i = 0; i < state.currentListSubject.length; i++) {
      if (state.currentListSubject[i].isSelected ?? false) {
        state.countSubjectSelected.value++;
      }
    }
    state.countSubjectSelected.refresh();
    state.listSubject.refresh();
  }

  void fetchData() {
    state.stateLoading.value = true;

    state.mergeRequest.listen((p0) {
      if (p0 <= 0) {
        state.stateLoading.value = false;
      }
    });

    state.mergeRequest.value++;
    FirebaseFirestore.instance.collection('Subject').get().then((value) {
      state.currentListSubject.clear();
      value.docs.map((e) {
        var response = SubjectResponse.fromJson(e.data());
        state.currentListSubject.add(response);
      }).toList();
      state.mergeRequest.value--;
    }).catchError((onError) {
      state.mergeRequest.value--;
      AppSnackBar.showError(
        title: 'Error',
        message: 'Fetch data failure',
      );
    });

    state.mergeRequest.value++;
    FirebaseFirestore.instance.collection('Specialized').get().then((value) {
      state.listSpecialized.clear();
      value.docs.map((e) {
        var response = SpecializedResponse.fromJson(e.data());
        response.icon = state.listIcon[Random().nextInt(6)];
        state.listSpecialized.add(response);
      }).toList();
      state.mergeRequest.value--;
    }).catchError((onError) {
      state.mergeRequest.value--;
      AppSnackBar.showError(
        title: 'Error',
        message: 'Fetch data failure',
      );
    });
  }

  void checkSpecializedSelected(String id) {
    for (int i = 0; i < state.listSpecialized.length; i++) {
      if (state.listSpecialized[i].displayName == id) {
        state.specializedSelected.value = state.listSpecialized[i];
        state.nameSpecializedTextController.text =
            state.specializedSelected.value.id ?? '';
      }
    }

    //reload list subject in specialized
    state.stateLoading.value = true;
    state.listSubject.clear();
    state.listSubject.refresh();
    for (int i = 0; i < state.currentListSubject.length; i++) {
      if (state.currentListSubject[i].idSpecialized ==
          state.specializedSelected.value.id) {
        state.listSubject.add(state.currentListSubject[i]);
        break;
      }
    }
    state.listSubject.refresh();
    state.stateLoading.value = false;
  }
}
