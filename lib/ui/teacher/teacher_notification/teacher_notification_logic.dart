import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/response/notification_response.dart';
import 'package:qldt/ui/teacher/teacher_notification/teacher_notification_state.dart';

class TeacherNotificationLogic extends GetxController {
  final state = TeacherNotificationState();

  TeacherNotificationLogic() {
    fetchData();
  }

  void fetchData() {
    FirebaseFirestore.instance
        .collection('Notification')
        .get()
        .then((value) {
          state.listNotification.clear();
          value.docs.map((e){
          var response = NotificationResponse.fromJson(e.data());
          if(response.time==''||response.time==null){
            response.time = DateTime.now().toString();
          }
          state.listNotification.add(response);
          }).toList();
          state.listNotification.refresh();
    })
        .catchError((onError) {
      AppSnackBar.showError(title: 'Error', message: 'Fetch data error');
    });
  }
}
