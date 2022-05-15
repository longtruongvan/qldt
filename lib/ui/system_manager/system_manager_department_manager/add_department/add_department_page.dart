import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/add_department/add_department_logic.dart';
import 'package:qldt/ui/widgets/textfields/app_label_text_field.dart';
import 'package:qldt/ui/widgets/textfields/app_text_field.dart';

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
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppbarWidget(),
                const SizedBox(
                  height: AppDimens.spacingNormal,
                ),
                AppLabelTextField(
                  title: 'Name department',
                  hintText: "Name department",
                  titleStyle: AppTextStyle.colorDartS16W500,
                  hintStyle: AppTextStyle.colorGrayS14W500,
                  controller: state.nameTextController,
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
                  onTap: (){
                    
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
                )
              ],
            ),
          ),
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
