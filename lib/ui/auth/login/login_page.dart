import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_dimens.dart';
import 'package:qldt/common/app_text_style.dart';
import 'package:qldt/ui/auth/login/login_logic.dart';
import 'package:qldt/ui/widgets/textfields/app_email_input.dart';
import 'package:qldt/ui/widgets/textfields/app_label_text_field.dart';
import 'package:qldt/ui/widgets/textfields/app_password_input.dart';
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // AppLabelTextField(
              //   title: 'Email',
              //   hintText: 'Input email',
              //   controller: state.emailTextController,
              // ),
              // AppLabelTextField(
              //   title: 'Password',
              //   hintText: 'Input password',
              //   controller: state.passwordTextController,
              // ),
              AppEmailInput(
                hintText: 'Email',
                controller: state.emailTextController,
              ),
              const SizedBox(height: AppDimens.spacingNormal),
              AppPasswordInput(
                hintText: 'Password',
                controller: state.passwordTextController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                enableSuggestions: false,
                autoCorrect: false,
                // obscuringCharacter: '*',
              ),
              const SizedBox(height: AppDimens.spacingNormal),
              Text(
                'Forgot Password?',
                style: AppTextStyle.colorDarkGrayW500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
