import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/response/notification_response.dart';
import 'package:qldt/services/auth_service.dart';
import 'package:qldt/ui/splash/splash_logic.dart';
import 'package:qldt/ui/teacher/teacher_notification/teacher_notification_state.dart';

class TeacherNotificationLogic extends GetxController {
  final state = TeacherNotificationState();
  final auth = Get.find<AuthService>();

  TeacherNotificationLogic() {}

  void fetchData(PersonType personType) {
    state.statusLoading.value = true;
    FirebaseFirestore.instance
        .collection('Notification')
        .orderBy('time', descending: true)
        .snapshots()
        .listen((value) {
      state.listNotification.clear();
      value.docs.map((e) {
        var response = NotificationResponse.fromJson(e.data());
        if (response.time == '' || response.time == null) {
          response.time = DateTime.now().toString();
        }
        if (personType != PersonType.QTHT &&
            response.idReceiver != null &&
            response.idReceiver == auth.person.value?.id) {
          state.listNotification.add(response);
        } else if (personType == PersonType.QTHT &&
            response.typeNotification != null &&
            response.typeNotification != 'WELCOME') {
          state.listNotification.add(response);
        }
      }).toList();
      state.listNotification.refresh();
      state.statusLoading.value = false;
    }).onError((handleError) {
      AppSnackBar.showError(title: 'Error', message: 'Fetch data error');
      state.statusLoading.value = false;
    });
  }
}
