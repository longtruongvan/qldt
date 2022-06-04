import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/response/subject_response.dart';
import 'package:qldt/ui/system_manager/subjects/detail_subject/detail_subject_state.dart';

import '../../../../model/response/specialized_response.dart';

class DetailSubjectLogic extends GetxController {
  final state = DetailSubjectState();

  void initData(SubjectResponse subjectResponse) {
    state.nameSubjectTextController.text = subjectResponse.name ?? '';
    state.codeSubjectTextController.text = subjectResponse.code ?? '';
    state.numberOfLessonTextController.text =
        '${subjectResponse.numberOffLesson ?? 0}';

    state.stateLoading.value = true;
    FirebaseFirestore.instance.collection('Specialized').get().then((value) {
      state.listSpecialized.clear();
      value.docs.map((data) {
        var response = SpecializedResponse.fromJson(data.data());
        state.listSpecialized.add(response);
        if (subjectResponse.idSpecialized == response.id) {
          state.nameSpecializedTextController.text = response.displayName ?? '';
          state.specializedSelected.value = response;
          state.specializedSelected.refresh();
        }
      }).toList();
      state.stateLoading.value = false;
    }).catchError((onError) {
      AppSnackBar.showError(title: 'Error', message: 'Fetch data failure');
      state.stateLoading.value = false;
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
  }

  void updateSubject(
      SubjectResponse subjectResponse, Function(SubjectResponse) callback) {
    if (state.nameSpecializedTextController.text == '' ||
        state.nameSubjectTextController.text == '' ||
        state.codeSubjectTextController.text == '' ||
        state.numberOfLessonTextController.text == '') {
      AppSnackBar.showWarning(
          title: 'Warning', message: 'Please enter enough information');
      return;
    }
    state.stateLoading.value = true;
    subjectResponse.name = state.nameSubjectTextController.text;
    subjectResponse.idSpecialized = state.specializedSelected.value.id;
    subjectResponse.code = state.codeSubjectTextController.text;
    subjectResponse.numberOffLesson =
        int.tryParse(state.numberOfLessonTextController.text);

    FirebaseFirestore.instance
        .collection('Subject')
        .doc(subjectResponse.id)
        .update(subjectResponse.toJson())
        .then((value) {
      callback(subjectResponse);
      Get.back(closeOverlays: true);
      AppSnackBar.showSuccess(
          title: 'Success', message: 'Update subject success');
    }).catchError((onError) {
      state.stateLoading.value = false;
      AppSnackBar.showError(title: 'Error', message: 'Update subject failure');
    });
  }

  void deleteSubject(String id) {
    state.stateLoading.value = true;
    FirebaseFirestore.instance
        .collection('Subject')
        .doc(id)
        .delete()
        .then((value) {
      Get.back();
      Get.back(closeOverlays: true);
      AppSnackBar.showSuccess(
          title: 'Success', message: 'Delete subject success');
    }).catchError((onError) {
      state.stateLoading.value = false;
      AppSnackBar.showError(title: 'Error', message: 'Delete subject failure');
    });
  }
}
