import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/ui/auth/sign_up/sign_up_logic.dart';
import 'package:qldt/ui/widgets/button/back_button.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_dimens.dart';
import '../../../common/app_images.dart';
import '../../../common/app_text_style.dart';
import '../../widgets/button/app_button.dart';
import '../../widgets/textfields/app_email_input.dart';
import '../../widgets/textfields/app_password_input.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final logic = Get.put(SignUpLogic());
  final state = Get.find<SignUpLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _buildBodyWidget(),
          _buildBackButton(),
        ],
      ),
    );
  }

  Widget _buildBodyWidget() {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppDimens.spacingNormal,
            right: AppDimens.spacingNormal,
            bottom: 20.0,
            top: 52.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.logoSignUp,
                // width: 24,
                // height: 24,
              ),
              const SizedBox(height: AppDimens.spacingNormal),
              Text(
                'Sign up',
                style: AppTextStyle.colorDarkS24W500,
              ),
              const SizedBox(height: 8),
              Text(
                'Create your account',
                style: AppTextStyle.colorDarkGrayS14W400,
              ),
              const SizedBox(height: AppDimens.spacingNormal),
              AppEmailInput(
                hintText: 'Name',
                errorText: 'Please check your registration name again',
                controller: state.emailTextController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: AppDimens.spacingNormal),
              AppEmailInput(
                hintText: 'E-mail',
                errorText: 'Please check your email again',
                controller: state.emailTextController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: AppDimens.spacingNormal),
              Obx(
                () => AppPasswordInput(
                  hintText: 'Password',
                  errorText: 'Please check your password again',
                  controller: state.passwordTextController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !state.showPassword.value,
                  enableSuggestions: false,
                  autoCorrect: false,
                  textInputAction: TextInputAction.done,
                  // obscuringCharacter: '*',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      logic.showPassword();
                    },
                    child: Image.asset(
                      (state.showPassword.value)
                          ? AppImages.icShowPassword
                          : AppImages.icHidePassword,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppDimens.spacingNormal),
              const AppButton(
                title: 'Sign up',
              ),
              const SizedBox(height: AppDimens.spacingNormal),
              GestureDetector(
                onTap: () {
                  logic.backPress();
                },
                child: Container(
                  margin: const EdgeInsets.all(AppDimens.spacingNormal),
                  child: Text(
                    'Log in',
                    style: AppTextStyle.colorDarkGrayS14W500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Positioned(
        top: AppDimens.spacingNormal,
        left: AppDimens.spacingNormal,
        child: SafeArea(
          child: AppBackButton(eventHandler: logic.backPress,),
        ));
  }
}
