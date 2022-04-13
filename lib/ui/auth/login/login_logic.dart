import 'package:get/get.dart';
import 'package:qldt/ui/auth/login/login_state.dart';
import 'package:qldt/ui/auth/sign_up/sign_up_page.dart';

class LoginLogic extends GetxController {
  final state = LoginState();

  void showPassword(){
    state.showPassword.value = !state.showPassword.value;
  }

  void goToSignUpScreen(){
    Get.to(const SignUpPage());
  }
}
