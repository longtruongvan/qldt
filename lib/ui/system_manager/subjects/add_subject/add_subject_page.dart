import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_dimens.dart';
import 'package:qldt/ui/system_manager/subjects/add_subject/add_subject_logic.dart';

import '../../../../common/app_text_style.dart';
import '../../../widgets/button/back_button.dart';
import '../../../widgets/textfields/app_label_text_field.dart';

class AddSubjectPage extends StatefulWidget {
  final Function(String id) callback;

  const AddSubjectPage({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  State<AddSubjectPage> createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {
  final logic = Get.put(AddSubjectLogic());
  final state = Get.find<AddSubjectLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppDimens.spacingNormal),
          child: _buildAppbarWidget(),
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      body: Container(
        color: AppColors.whiteColor,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildBodyWidget(),
            _buildButtonSubmitWidget(),
            _buildLoadingWidget(),
          ],
        ),
      ),
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

  Widget _buildButtonSubmitWidget() {
    return Positioned(
      child: Container(
        color: AppColors.whiteColor,
        child: GestureDetector(
          onTap: () {
            logic.addSubject((id){
              widget.callback(id);
            });
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
      bottom: AppDimens.spacingNormal,
    );
  }

  Widget _buildBodyWidget() {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Container(
        padding: const EdgeInsets.all(AppDimens.spacingNormal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            Text('Specialized', style: AppTextStyle.colorDarkS16W500),
            const SizedBox(height: 10),
            _buildSelectSpecializedWidget(),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            AppLabelTextField(
              title: 'Name subject',
              hintText: "Ex: Flutter",
              titleStyle: AppTextStyle.colorDarkS16W500,
              hintStyle: AppTextStyle.colorGrayS14W500,
              controller: state.nameSubjectTextController,
              spacingTitleAndTextField: 10,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            AppLabelTextField(
              title: 'Code subject',
              hintText: "Ex: Flutter2022",
              titleStyle: AppTextStyle.colorDarkS16W500,
              hintStyle: AppTextStyle.colorGrayS14W500,
              controller: state.codeSubjectTextController,
              spacingTitleAndTextField: 10,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            AppLabelTextField(
              title: 'Number of lesson',
              hintText: "Ex: 60",
              titleStyle: AppTextStyle.colorDarkS16W500,
              hintStyle: AppTextStyle.colorGrayS14W500,
              controller: state.numberOfLessonTextController,
              spacingTitleAndTextField: 10,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }

  List<int> _getDividersIndexes() {
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (state.listSpecialized.length * 2) - 1; i++) {
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }

  Widget _buildSelectSpecializedWidget() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.spacingNormal),
          border: Border.all(color: AppColors.grayColor, width: 1),
        ),
        child: DropdownButton2(
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.grayColor,
          ),
          isExpanded: true,
          underline: Container(
            color: AppColors.whiteColor,
          ),
          value: state.specializedSelected.value.displayName,
          hint:
              Text('Select specialized', style: AppTextStyle.colorGrayS18W500),
          onChanged: (value) {
            logic.checkSpecializedSelected(value as String);
          },
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.spacingNormal),
          ),
          dropdownWidth: Get.width - 32,
          buttonWidth: Get.width - 32,
          offset: const Offset(-11, -AppDimens.spacingNormal),
          items: state.listSpecialized.map((element) {
            return DropdownMenuItem<String>(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    element.displayName ?? '',
                    style: AppTextStyle.color3C3A36S18W500,
                  ),
                  const Spacer(),
                ],
              ),
              value: element.displayName,
            );
          }).toList(),
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
          child: Text('Add Subjects', style: AppTextStyle.colorDarkS24W500),
        ),
      ],
    );
  }
}
