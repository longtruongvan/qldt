import 'package:get/get.dart';
import 'package:qldt/ui/auth/sign_up/sign_up_state.dart';

class SignUpLogic extends GetxController {
  final state = SignUpState();

  void showPassword(){
    state.showPassword.value = !state.showPassword.value;
  }

  void backPress(){
    Get.back();
  }
}
