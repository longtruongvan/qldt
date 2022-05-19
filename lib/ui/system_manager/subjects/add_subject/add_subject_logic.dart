import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/response/specialized_response.dart';
import 'package:qldt/model/response/subject_response.dart';
import 'package:qldt/ui/system_manager/subjects/add_subject/add_subject_state.dart';
import 'package:uuid/uuid.dart';

class AddSubjectLogic {
  final state = AddSubjectState();

  AddSubjectLogic() {
    fetchData();
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

  void fetchData() {
    state.stateLoading.value = true;
    FirebaseFirestore.instance.collection('Specialized').get().then((value) {
      state.listSpecialized.clear();
      value.docs.map((data) {
        var response = SpecializedResponse.fromJson(data.data());
        state.listSpecialized.add(response);
      }).toList();
      state.stateLoading.value = false;
    }).catchError((onError) {
      AppSnackBar.showError(title: 'Error', message: 'Fetch data failure');
      state.stateLoading.value = false;
    });
  }

  void addSubject(Function(String id) callback) {
    if (state.nameSpecializedTextController.text == '' ||
        state.nameSubjectTextController.text == '' ||
        state.codeSubjectTextController.text == '' ||
        state.numberOfLessonTextController.text == '') {
      AppSnackBar.showWarning(
          title: 'Warning', message: 'Please enter enough information');
      return;
    }
    state.stateLoading.value = true;
    String id = const Uuid().v1();
    FirebaseFirestore.instance
        .collection('Subject')
        .doc(id)
        .set(
          SubjectResponse(
            id: id,
            idSpecialized: state.specializedSelected.value.id,
            name: state.nameSubjectTextController.text,
            code: state.codeSubjectTextController.text,
            numberOffLesson:
                int.tryParse(state.numberOfLessonTextController.text),
          ).toJson(),
        )
        .then((value) {
      callback(id);
      state.stateLoading.value = false;
      Get.back(closeOverlays: true);
      AppSnackBar.showSuccess(title: 'Success', message: 'Add subject success');
    }).catchError((onError) {
      AppSnackBar.showError(title: 'Error', message: 'Add subject failure');
      state.stateLoading.value = false;
    });
  }
}
