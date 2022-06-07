import 'dart:math';

import 'package:get/get.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/generated/l10n.dart';
import 'package:qldt/ui/system_manager/manager_user/create_user/create_user_state.dart';
import 'package:qldt/utils/authentication.dart';
import 'package:qldt/utils/util.dart';

class CreateUserLogic extends GetxController {
  final state = CreateUserState();

  void createUserHandler() async {
    if (state.classResponseSelected.value.name == null ||
        state.numberTextEditingController.text == '') {
      AppSnackBar.showWarning(
        title: S.current.common_warning,
        message: S.current.common_enter_enough_information,
      );
      return;
    }
    state.statusLoading.value = true;

    int? number = int.tryParse(state.numberTextEditingController.text);
    if ((number ?? 0) <= 0) {
      return;
    }

    RxInt dispatchGroup = 0.obs;
    dispatchGroup.listen((p0) {
      if(p0<=0){
        state.statusLoading.value = false;
        Get.back(closeOverlays: true);
        AppSnackBar.showSuccess(
          title: S.current.common_success,
          message: S.current.create_user_state_success,
        );
      }
    });
    for (int i = 0; i < number!; i++) {
      dispatchGroup.value++;
      // registerWithEmailPassword
      String codeStudent =
          '69DCHT${Util.generateRandomString(7)}'.toUpperCase();
      String emailStudent = '69DCHT${Util.generateRandomString(7)}@gmail.com';
      String password = '123456';
      await Authentication.registerWithEmailPassword(
        email: emailStudent,
        password: password,
        idSpecialized: state.classResponseSelected.value.specializedID ?? '',
        idClass: state.classResponseSelected.value.id ?? '',
        codeStudent: codeStudent,
        callback: () {
          dispatchGroup.value--;
        },
      );
    }
  }
}
