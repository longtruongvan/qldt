import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/entity/day_of_week_entity.dart';
import 'package:qldt/model/entity/subject_entity.dart';
import 'package:qldt/model/request/propossed_time_request.dart';
import 'package:qldt/model/request/subject_register_request.dart';
import 'package:qldt/model/response/specialized_response.dart';
import 'package:qldt/services/auth_service.dart';
import 'package:qldt/ui/student/student_register_subject_2/student_register_subject_next_state.dart';
import 'package:uuid/uuid.dart';

import '../../../model/response/subject_response.dart';

class StudentRegisterSubjectNextLogic extends GetxController {
  final state = StudentRegisterSubjectNextState();
  final authService = Get.find<AuthService>();

  void initData(
      List<SubjectResponse> listData, SpecializedResponse specializedResponse) {
    state.specializedResponse.value = specializedResponse;
    state.listSubject.clear();
    state.listSubject.addAll(listData);
    for (int i = 0; i < listData.length; i++) {
      state.listSubjectEntity.add(SubjectEntity(
          numberOfPreiodTextController: TextEditingController(text: ''),
          preiodStartTextController: TextEditingController(text: ''),
          subjectResponse: listData[i],
          listDayOfWeek: [
            DayOffWeekEntity(
              day: 'Mon',
              isSelected: false,
            ),
            DayOffWeekEntity(
              day: 'Tues',
              isSelected: false,
            ),
            DayOffWeekEntity(
              day: 'Wed',
              isSelected: false,
            ),
            DayOffWeekEntity(
              day: 'Thurs',
              isSelected: false,
            ),
            DayOffWeekEntity(
              day: 'Fri',
              isSelected: false,
            ),
            DayOffWeekEntity(
              day: 'Sat',
              isSelected: false,
            ),
            DayOffWeekEntity(
              day: 'Sun',
              isSelected: false,
            ),
          ]));
    }
  }

  void submitButtonClickListener() {
    state.statusLoading.value = true;

    int count = 0;
    for (int i = 0; i < state.listSubjectEntity.length; i++) {
      count = 0;
      for (int k = 0;
          k < state.listSubjectEntity[i].listDayOfWeek!.length;
          k++) {
        if (state.listSubjectEntity[i].listDayOfWeek![k].isSelected ?? false) {
          count++;
        }

        if (state.listSubjectEntity[i].preiodStartTextController!.text == '' ||
            state.listSubjectEntity[i].numberOfPreiodTextController!.text ==
                '') {
          state.statusLoading.value = false;
          AppSnackBar.showWarning(
              title: 'Warning', message: 'Please enter the enough information');
          return;
        }
      }
      if (count == 0) {
        state.statusLoading.value = false;
        AppSnackBar.showWarning(
            title: 'Warning', message: 'Please select the time learning');
        return;
      }
    }

    var period = '';
    var numberOfPeriod = '';
    String id = '';
    String idPropossed = '';
    List<SubjectRegisterRequest> listRequest = [];
    for (int i = 0; i < state.listSubjectEntity.length; i++) {
      period = '';
      numberOfPeriod = '';
      id = '';
      idPropossed = '';
      List<String> arrDayOfWeek = [];
      for (int k = 0;
          k < state.listSubjectEntity[i].listDayOfWeek!.length;
          k++) {
        period = state.listSubjectEntity[i].preiodStartTextController!.text;
        numberOfPeriod =
            state.listSubjectEntity[i].numberOfPreiodTextController!.text;
        if (state.listSubjectEntity[i].listDayOfWeek![k].isSelected ?? false) {
          arrDayOfWeek
              .add(state.listSubjectEntity[i].listDayOfWeek![k].day ?? '');
        }
      }
      id = const Uuid().v1();
      idPropossed = const Uuid().v4();
      var request = SubjectRegisterRequest(
        id: id,
        idSender: authService.user.value!.uid,
        idSpecialized: state.specializedResponse.value.id,
        timeRequest: DateTime.now().toString(),
        subjectIds: state.listSubject[i].id,
        isAccept: false,
        propossedTime: PropossedTimeRequest(
          id: idPropossed,
          dayOfWeek: arrDayOfWeek,
          period: period,
          numberOfPeriod: numberOfPeriod,
        ),
      );
      listRequest.add(request);
    }

    bool isFailure = false;
    state.mergeRequest.listen((p0) {
      if (p0 <= 0) {
        state.statusLoading.value = false;
        if(!isFailure){
          AppSnackBar.showSuccess(title: 'Success', message: 'Register success');
        }
      }
    });

    for (int i = 0; i < listRequest.length; i++) {
      state.mergeRequest.value++;
      FirebaseFirestore.instance
          .collection('Course')
          .doc(listRequest[i].id)
          .set(listRequest[i].toJson())
          .then((value) {
        state.mergeRequest.value--;
      }).catchError((onError) {
        state.mergeRequest.value--;
        isFailure = true;
        AppSnackBar.showError(title: 'Error', message: 'Register failure');
      });

      state.mergeRequest.value++;
      FirebaseFirestore.instance
          .collection('Person')
          .doc(authService.user.value?.uid ?? '')
          .set({
        'idCourse': [listRequest[i].id]
      }).then((value) {
        state.mergeRequest.value--;
      }).catchError((onError) {
        state.mergeRequest.value--;
        isFailure = true;
        AppSnackBar.showError(title: 'Error', message: 'Register failure');
      });
    }
  }
}
