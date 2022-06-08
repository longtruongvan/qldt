import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/response/subject_response.dart';

import '../../../generated/l10n.dart';
import 'subject_state.dart';

class SubjectLogic extends GetxController {
  final state = SubjectState();

  SubjectLogic() {
    fetchData();
  }

  void searchHandler(String value) {
    if (value == '') {
      state.listSubject.clear();
      state.listSubject.addAll(state.currentListSubject);
      return;
    }
    String content = "";
    state.listSubject.clear();
    for (int i = 0; i < state.currentListSubject.length; i++) {
      content = '${state.currentListSubject[i].name}';
      if (content.toLowerCase().contains(value.toLowerCase())) {
        state.listSubject.add(state.currentListSubject[i]);
      }
    }
  }

  void getSubjectById(String id) {
    FirebaseFirestore.instance
        .collection('Subject')
        .doc(id)
        .get()
        .then((value) {
      if (value.data() != null) {
        var response = SubjectResponse.fromJson(value.data()!);
        response.icon = state.listIcon[Random().nextInt(6)];
        state.listSubject.add(response);
        state.currentListSubject.add(response);
      }
    }).catchError((onError) {
      state.stateLoading.value = false;
      AppSnackBar.showError(title: S.current.common_error, message: S.current.common_fetch_data_failure);
    });
  }

  void fetchData() {
    state.stateLoading.value = true;
    FirebaseFirestore.instance.collection('Subject').get().then((value) {
      state.listSubject.clear();
      state.currentListSubject.clear();
      value.docs.map((e) {
        var response = SubjectResponse.fromJson(e.data());
        response.icon = state.listIcon[Random().nextInt(6)];
        state.listSubject.add(response);
        state.currentListSubject.add(response);
      }).toList();
      state.stateLoading.value = false;
      if (state.searchTextController.text != '') {
        searchHandler(state.searchTextController.text);
      }
    }).catchError((onError) {
      state.stateLoading.value = false;
      AppSnackBar.showError(title: S.current.common_error, message: S.current.common_fetch_data_failure);
    });
  }

  void updateSubject(SubjectResponse response) {
    int index = state.currentListSubject.indexWhere((p0) => p0.id == response.id);
    if (index >= 0) {
      state.currentListSubject[index] = response;
      state.listSubject[index] = response;
      state.currentListSubject.refresh();
      state.listSubject.refresh();
    }
  }
}
