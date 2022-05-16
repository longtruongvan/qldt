import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/add_department/add_department_logic.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/add_department_dialog_choose_building/dialog_choose_building.dart';
import 'package:qldt/ui/widgets/textfields/app_label_text_field.dart';

import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../widgets/button/back_button.dart';

class AddDepartmentPage extends StatefulWidget {
  const AddDepartmentPage({Key? key}) : super(key: key);

  @override
  State<AddDepartmentPage> createState() => _AddDepartmentPageState();
}

class _AddDepartmentPageState extends State<AddDepartmentPage> {
  final logic = Get.put(AddDepartmentLogic());
  final state = Get.find<AddDepartmentLogic>().state;

  @override
  void dispose() {
    Get.delete<AddDepartmentLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildBodyWidget(),
            _buildLoadingWidget(),
            _buildButtonSubmitWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonSubmitWidget() {
    return Positioned(
      child: Container(
        color: AppColors.whiteColor,
        child: GestureDetector(
          onTap: (){
            logic.addDepartmentHandel();
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20)),
            height: 60,
            child: Center(
                child: Text(
              "OK",
              style: AppTextStyle.colorWhiteS16
                  .copyWith(fontWeight: FontWeight.w500),
            )),
          ),
        ),
      ),
      left: AppDimens.spacingNormal,
      right: AppDimens.spacingNormal,
      bottom: 0,
    );
  }

  Widget _buildLoadingWidget() {
    return Obx(
      () => Visibility(
        visible: state.stateLoading.value,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppbarWidget(),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            GestureDetector(
              onTap: () {
                Get.dialog(
                  DialogChooseBuilding(
                    listBuilding: state.listBuilding.value,
                    callback: (value) {
                      logic.updateItemSelected(value);
                    },
                  ),
                );
              },
              child: AppLabelTextField(
                title: 'Select building',
                hintText: "Select building",
                titleStyle: AppTextStyle.colorDartS16W500,
                hintStyle: AppTextStyle.colorGrayS14W500,
                controller: state.nameBuildingTextController,
                spacingTitleAndTextField: 10,
                isEnable: false,
                iconSuffix: const Icon(Icons.arrow_drop_down),
              ),
            ),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            AppLabelTextField(
              title: 'Name department',
              hintText: "Name department",
              titleStyle: AppTextStyle.colorDartS16W500,
              hintStyle: AppTextStyle.colorGrayS14W500,
              controller: state.nameDepartmentTextController,
              spacingTitleAndTextField: 10,
            ),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            AppLabelTextField(
              title: 'Location department',
              hintText: "Location department",
              titleStyle: AppTextStyle.colorDartS16W500,
              hintStyle: AppTextStyle.colorGrayS14W500,
              controller: state.locationTextController,
              spacingTitleAndTextField: 10,
            ),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            AppLabelTextField(
              title: 'Description department',
              hintText: "Description department",
              titleStyle: AppTextStyle.colorDartS16W500,
              hintStyle: AppTextStyle.colorGrayS14W500,
              controller: state.descriptionTextController,
              spacingTitleAndTextField: 10,
            ),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            Text(
              'Image department',
              style: AppTextStyle.colorDartS16W500,
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                logic.pickImageHandler();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: AppColors.grayColor,
                    width: 1,
                  ),
                ),
                width: Get.width,
                height: 170,
                child: const Center(
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                    color: AppColors.grayColor,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppbarWidget() {
    return Row(
      children: [
        AppBackButton(eventHandler: () {
          Get.back();
        }),
        const SizedBox(width: AppDimens.spacingNormal),
        Text(
          "Add department",
          style: AppTextStyle.colorDarkS24W500,
        ),
      ],
    );
  }
}

class _dialogSelectBuilding extends StatelessWidget {
  const _dialogSelectBuilding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
