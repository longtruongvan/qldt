import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/model/response/notification_response.dart';
import 'package:qldt/model/response/tuition_response.dart';
import 'package:qldt/services/auth_service.dart';
import 'package:qldt/ui/teacher/tuition/create_tution/create_tuition_state.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/app_snack_bar.dart';
import '../../../../model/response/class_response.dart';
import '../../../../model/response/person_response.dart';
import '../../../../model/response/specialized_response.dart';
import '../../../splash/splash_logic.dart';

class CreateTuitionLogic extends GetxController {
  final state = CreateTuitionState();
  final authService = Get.find<AuthService>();

  CreateTuitionLogic() {
    fetchData();
  }

  void addTuitionToTablePerson(
      TuitionResponse tuitionResponse, Function(bool) callback) {
    FirebaseFirestore.instance
        .collection('Person')
        .doc(tuitionResponse.idStudent)
        .update({
      'idTuition': FieldValue.arrayUnion([tuitionResponse.id])
    }).then((value) {
      callback(true);
    }).onError((error, stackTrace) {
      callback(false);
    });
  }

  void pushTuitionToDB(
      TuitionResponse tuitionResponse, Function(bool) callback) {
    FirebaseFirestore.instance
        .collection('Tuition')
        .doc(tuitionResponse.id)
        .set(tuitionResponse.toJson())
        .then((value) {
      callback(true);
    }).onError((error, stackTrace) {
      callback(false);
    });
  }

  void submitHandler() {
    if (state.specializedSelected.value.id == null ||
        state.classResponseSelected.value.id == null ||
        state.tuitionTextController.text == '') {
      AppSnackBar.showWarning(
          title: 'Warning', message: 'Please enter enough information');
      return;
    }
    state.statusLoading.value = true;
    String id = const Uuid().v1();
    List<TuitionResponse> listTuition = [];
    for (int i = 0; i < state.listPersonResponse.length; i++) {
      TuitionResponse response = TuitionResponse(
        id: id,
        idStudent: state.listPersonResponse[i].id,
        state: false,
        price: double.tryParse(state.tuitionTextController.text),
        schoolYear: state.yearSchoolSelected.value,
        semester: state.listSemester[state.semesterPositionSelected.value],
      );
      listTuition.add(response);
    }

    RxInt dispatchGroup = 0.obs;
    int countSuccess = 0;
    int countFailure = 0;
    dispatchGroup.listen((value) {
      if (value <= 0) {
        FirebaseFirestore.instance
            .collection('Notification')
            .doc()
            .set(NotificationResponse(
              id: const Uuid().v1(),
              isRead: false,
              title:
                  'Thông báo đóng học phí năm học ${state.yearSchoolSelected.value}',
              time: DateTime.now().toString(),
              avatarUrl: authService.user.value?.photoURL,
              typeNotification: 'HOC_PHI',
            ).toJson())
            .then((value) {
          Get.back(closeOverlays: true);
          AppSnackBar.showSuccess(
              title: 'Success', message: 'Add tuition success');
          state.statusLoading.value = false;
        }).catchError((onError) {
          AppSnackBar.showError(title: 'Error', message: 'Add tuition failure');
          state.statusLoading.value = false;
        });
      }
    });

    for (int i = 0; i < listTuition.length; i++) {
      dispatchGroup.value++;
      dispatchGroup.value++;
      pushTuitionToDB(listTuition[i], (status) {
        dispatchGroup.value--;
        if (status) {
          countSuccess++;
        } else {
          countFailure++;
        }
      });
      addTuitionToTablePerson(listTuition[i], (status) {
        dispatchGroup.value--;
        if (status) {
          countSuccess++;
        } else {
          countFailure++;
        }
      });
    }
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
        state.yearSchool.clear();
        state.yearSchoolSelected.value = 'All';
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
    state.statusLoading.value = true;
    RxInt dispatchGroup = 0.obs;

    dispatchGroup.value++;
    dispatchGroup.value++;
    dispatchGroup.value++;

    dispatchGroup.listen((p0) {
      if (p0 <= 0) {
        state.statusLoading.value = false;
      }
    });

    // Get Specialized
    FirebaseFirestore.instance.collection('Specialized').get().then((value) {
      state.currentListSpecialized.clear();
      state.listSpecialized.clear();
      value.docs.map((e) {
        var response = SpecializedResponse.fromJson(e.data());
        state.currentListSpecialized.add(response);
        state.listSpecialized.add(response);
      }).toList();
      dispatchGroup.value--;
    }).catchError((onError) {
      AppSnackBar.showError(
          title: 'Error', message: 'Get data specialized failure');
      dispatchGroup.value--;
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
      dispatchGroup.value--;
    }).catchError((onError) {
      AppSnackBar.showError(title: 'Error', message: 'Get data class failure');
      dispatchGroup.value--;
    });

    // Get Person
    FirebaseFirestore.instance.collection('Person').get().then((value) {
      state.currentListPersonResponse.clear();
      state.listPersonResponse.clear();
      value.docs.map((e) {
        var response = PersonResponse.fromJson(e.data());
        if (response.type == PersonType.SV.name) {
          state.currentListPersonResponse.add(response);
          state.listPersonResponse.add(response);
        }
      }).toList();
      dispatchGroup.value--;
    }).catchError((onError) {
      AppSnackBar.showError(
          title: 'Error', message: 'Get data student failure');
      dispatchGroup.value--;
    });
  }
}
