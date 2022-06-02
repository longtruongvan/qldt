import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/response/person_response.dart';
import 'package:qldt/ui/system_manager/manager_user/manager_user_state.dart';

class ManagerUserLogic extends GetxController {
  final state = ManagerUserState();

  ManagerUserLogic() {
    fetchData();
  }

  void searchHandler(String text) {
    if (text == '') {
      state.listPersonResponse.clear();
      state.listPersonResponse.addAll(state.currentListPersonResponse);
      return;
    }

    state.listPersonResponse.clear();
    for (int i = 0; i < state.currentListPersonResponse.length; i++) {
      if ((state.currentListPersonResponse[i].name??'')
          .toLowerCase()
          .contains(text.toLowerCase())) {
        state.listPersonResponse.add(state.currentListPersonResponse[i]);
      }
    }
  }

  void fetchData() {
    state.statusLoading.value = true;
    FirebaseFirestore.instance.collection('Person').get().then((value) {
      state.currentListPersonResponse.clear();
      state.listPersonResponse.clear();
      value.docs.map((e) {
        var response = PersonResponse.fromJson(e.data());
        state.listPersonResponse.add(response);
        state.currentListPersonResponse.add(response);
      }).toList();
      state.statusLoading.value = false;
      searchHandler(state.searchTextController.text);
    }).catchError((onError) {
      state.statusLoading.value = false;
      AppSnackBar.showError(title: 'Error', message: 'Fetch data failure');
    });
  }
}
