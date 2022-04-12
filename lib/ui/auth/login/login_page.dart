import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/ui/auth/login/login_logic.dart';
import 'package:qldt/ui/widgets/textfields/app_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final logic = Get.put(LoginLogic());
  final state = Get.find<LoginLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            children: [
              AppTextField(
                hintText: 'hint text',
                controller: state.emailTextController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
