import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/response/department_history_response.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/history_book_department/history_department_state.dart';

import '../../../../generated/l10n.dart';

class HistoryDepartmentLogic extends GetxController {
  final state = HistoryDepartmentState();

  HistoryDepartmentLogic() {
    fetchData();
  }

  void fetchData() {
    FirebaseFirestore.instance
        .collection('DepartmentOrderHistory')
        .snapshots()
        .listen((event) {
      state.listHistory.clear();
      event.docs.map((e) {
        var response = DepartmentHistoryResponse.fromJson(e.data());
        DateTime now = DateTime.parse(response.timeOrder ?? DateTime.now().toString());
        String formattedDate = DateFormat('dd-MM-yyyy - hh:mm:ss').format(now);
        response.timeFormat = formattedDate;
        state.listHistory.add(response);
      }).toList();
    }).onError((handleError) {
      AppSnackBar.showError(title: S.current.common_error, message: S.current.common_fetch_data_failure);
    });
  }
}
