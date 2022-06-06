import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/model/response/specialized_response.dart';
import 'package:qldt/ui/system_manager/specialized/update_specialized/update_specialized_logic.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../widgets/button/back_button.dart';
import '../../../widgets/textfields/app_label_text_field.dart';

class UpdateSpecializedPage extends StatefulWidget {
  final SpecializedResponse specializedResponse;
  final Function(SpecializedResponse) callback;

  const UpdateSpecializedPage({
    Key? key,
    required this.specializedResponse,
    required this.callback,
  }) : super(key: key);

  @override
  State<UpdateSpecializedPage> createState() => _UpdateSpecializedPageState();
}

class _UpdateSpecializedPageState extends State<UpdateSpecializedPage> {
  final logic = Get.put(UpdateSpecializedLogic());
  final state = Get.find<UpdateSpecializedLogic>().state;

  @override
  void initState() {
    logic.initData(widget.specializedResponse);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<UpdateSpecializedLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        bottom: PreferredSize(
          child: _buildAppbarWidget(),
          preferredSize: const Size.fromHeight(AppDimens.spacingNormal),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildBodyWidget(),
              _buildLoadingWidget(),
              _buildSubmitButtonWidget(),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }

  Widget _buildSubmitButtonWidget() {
    return Positioned(
      child: InkWell(
        onTap: () {
          logic.submitButtonClickListener(() {
            state.specializedResponse.value.name =
                state.nameTextController.text;
            state.specializedResponse.value.displayName =
                state.displayNameTextController.text;
            widget.callback(state.specializedResponse.value);
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.spacingNormal),
            color: AppColors.primaryColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 20),
          margin: const EdgeInsets.only(bottom: 20),
          child: Text(
            "OK",
            style: AppTextStyle.colorWhiteS16W500,
          ),
        ),
      ),
      bottom: 0,
      left: 0,
      right: 0,
    );
  }

  Widget _buildLoadingWidget() {
    return Obx(
      () => Visibility(
        visible: state.stateLoading.value,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          const SizedBox(height: AppDimens.spacingNormal),
          AppLabelTextField(
            title: 'Code',
            titleStyle: AppTextStyle.color3C3A36S18W500,
            hintText: 'input code',
            hintStyle: AppTextStyle.colorGrayS18W500,
            controller: state.codeTextController,
          ),
          const SizedBox(height: AppDimens.spacingNormal),
          AppLabelTextField(
            title: 'Name',
            titleStyle: AppTextStyle.color3C3A36S18W500,
            hintText: 'input name',
            hintStyle: AppTextStyle.colorGrayS18W500,
            controller: state.nameTextController,
          ),
          const SizedBox(height: AppDimens.spacingNormal),
          AppLabelTextField(
            title: 'Display name',
            titleStyle: AppTextStyle.color3C3A36S18W500,
            hintText: 'input display name',
            hintStyle: AppTextStyle.colorGrayS18W500,
            controller: state.displayNameTextController,
          )
        ],
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
          Get.back();
        }),
        const SizedBox(width: AppDimens.spacingNormal),
        Text(
          "Update specialized",
          style: AppTextStyle.colorDarkS24W500,
        ),
        const SizedBox(
          width: AppDimens.spacingNormal,
        ),
      ],
    );
  }
}
