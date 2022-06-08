import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/ui/system_manager/manager_user/select_class/select_class_page.dart';

import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/button/back_button.dart';
import '../../../widgets/textfields/app_text_field.dart';
import 'create_user_logic.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final logic = Get.put(CreateUserLogic());
  final state = Get.find<CreateUserLogic>().state;

  @override
  void dispose() {
    Get.delete<CreateUserLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppDimens.spacingNormal),
                    _buildAppbarWidget(),
                    const SizedBox(height: AppDimens.spacingNormal),
                    const Divider(height: 1, color: AppColors.grayColor),
                    const SizedBox(height: AppDimens.spacingNormal),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: AppDimens.spacingNormal),
                      child: Text(
                        S.of(context).common_select_class,
                        style: AppTextStyle.color3C3A36S20W500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Get.to(SelectClassPage(
                          callback: (classResponse) {
                            state.classResponseSelected.value = classResponse;
                            state.classResponseSelected.refresh();
                          },
                        ));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: AppDimens.spacingNormal),
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.grayColor,
                              width: 1,
                            )),
                        padding: const EdgeInsets.all(AppDimens.spacingNormal),
                        child: Row(
                          children: [
                            Obx(
                                  () => Text(
                                state.classResponseSelected.value.name ??
                                    S.of(context).common_select_class,
                                style: AppTextStyle.color3C3A36S18W500,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: AppColors.grayColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimens.spacingNormal),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: AppDimens.spacingNormal),
                      child: Text(
                        S.of(context).create_user_input_number_student,
                        style: AppTextStyle.color3C3A36S20W500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: AppDimens.spacingNormal,
                      ),
                      child: AppTextField(
                        maxLength: 2,
                        controller: state.numberTextEditingController,
                        hintText: S.of(context).create_user_input_number_student,
                        hintStyle: AppTextStyle.color3C3A36S20W500.copyWith(
                          color: AppColors.grayColor,
                        ),
                        textStyle: AppTextStyle.color3C3A36S20W500,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const Spacer(),
                    _buildSubmitButtonWidget()
                  ],
                ),
              ),
              _buildLoadingWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Obx(
          () => Visibility(
        visible: state.statusLoading.value,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildSubmitButtonWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimens.spacingNormal,
      ),
      color: AppColors.whiteColor,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          logic.createUserHandler();
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(20)),
          height: 60,
          child: Center(
              child: Text(
            S.of(context).common_next,
            style: AppTextStyle.colorWhiteS16
                .copyWith(fontWeight: FontWeight.w500),
          )),
        ),
      ),
    );
  }

  Widget _buildAppbarWidget() {
    return Row(
      children: [
        const SizedBox(
          width: AppDimens.spacingNormal,
        ),
        AppBackButton(eventHandler: () {
          Get.back(closeOverlays: true);
        }),
        const SizedBox(width: AppDimens.spacingNormal),
        Expanded(
          child: Text(S.of(context).createUser, style: AppTextStyle.colorDarkS24W500),
        ),
      ],
    );
  }
}
