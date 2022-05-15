import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_dimens.dart';
import 'package:qldt/common/app_images.dart';
import 'package:qldt/common/app_text_style.dart';
import 'package:qldt/ui/auth/login/login_logic.dart';
import 'package:qldt/ui/home/home_page.dart';
import 'package:qldt/ui/widgets/button/app_button.dart';
import 'package:qldt/ui/widgets/textfields/app_email_input.dart';
import 'package:qldt/ui/widgets/textfields/app_label_text_field.dart';
import 'package:qldt/ui/widgets/textfields/app_password_input.dart';
import 'package:qldt/ui/widgets/textfields/app_text_field.dart';

import '../../../utils/authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final logic = Get.put(LoginLogic());
  final state = Get.find<LoginLogic>().state;

  @override
  void dispose() {
    Get.delete<LoginLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Stack(
          children: [_buildBodyWidget(context), _buildLoadingWidget()],
        ),
      ),
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    return SafeArea(
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
              AppImages.logoLogin,
              // width: 24,
              // height: 24,
            ),
            const SizedBox(height: AppDimens.spacingNormal),
            Text(
              'Log in',
              style: AppTextStyle.colorDarkS24W500,
            ),
            const SizedBox(height: 8),
            Text(
              'Login with social networks',
              style: AppTextStyle.colorDarkGrayS14W400,
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                logic.clickLoginGoogleListener(context: context);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8),
                        // color: AppColors.secondaryColor,
                        boxShadow: [
                      BoxShadow(
                          color: AppColors.darkGrayColor.withOpacity(0.1)),
                    ]),
                child: Image.asset(
                  AppImages.logoGoogle,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            const SizedBox(height: AppDimens.spacingNormal),
            Obx(
              () => AppEmailInput(
                hintText: 'Email',
                errorText: (state.emailValidate.value)
                    ? null
                    : 'Please check your email again',
                controller: state.emailTextController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(height: AppDimens.spacingNormal),
            Obx(
              () => AppPasswordInput(
                hintText: 'Password',
                errorText: (state.passwordValidate.value)
                    ? null
                    : 'Please check your password again',
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
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(AppDimens.spacingNormal),
                child: Text(
                  'Forgot Password?',
                  style: AppTextStyle.colorDarkGrayS14W500,
                ),
              ),
            ),
            AppButton(
              title: 'Log in',
              textStyle: AppTextStyle.colorWhiteS16W500,
              onPress: () {
                logic.loginClickListener();
              },
            ),
            GestureDetector(
              onTap: () {
                logic.goToSignUpScreen();
              },
              child: Container(
                margin: const EdgeInsets.all(AppDimens.spacingNormal),
                child: Text(
                  'Sign up',
                  style: AppTextStyle.colorDarkGrayS14W500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Obx(() {
      if (state.statusLoading.value) {
        return const CircularProgressIndicator(
          color: AppColors.primaryColor,
        );
      }
      return Container();
    });
  }
}
