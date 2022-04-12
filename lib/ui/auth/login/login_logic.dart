import 'package:get/get.dart';
import 'package:qldt/ui/auth/login/login_state.dart';

class LoginLogic extends GetxController {
  final state = LoginState();

  void showPassword(){
    state.showPassword.value = !state.showPassword.value;
  }
}
