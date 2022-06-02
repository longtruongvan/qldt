import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/ui/teacher/tuition/create_tution/create_tuition_logic.dart';
import 'package:qldt/ui/teacher/tuition/tuition_logic.dart';

import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../widgets/button/back_button.dart';
import '../../../widgets/textfields/app_label_text_field.dart';

class CreateTuitionPage extends StatefulWidget {
  const CreateTuitionPage({Key? key}) : super(key: key);

  @override
  State<CreateTuitionPage> createState() => _CreateTuitionPageState();
}

class _CreateTuitionPageState extends State<CreateTuitionPage> {
  final logic = Get.put(CreateTuitionLogic());
  final state = Get.find<CreateTuitionLogic>().state;
  static const _locale = 'en';

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));

  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  void dispose() {
    Get.delete<CreateTuitionLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildAppbarWidget(),
                Expanded(child: _buildBodyWidget()),
              ],
            ),
            Positioned(
              child: _buildButtonSubmitWidget(),
              bottom: 0,
              left: 0,
              right: 0,
            ),
            _buildLoadingWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Obx(() {
      if (state.statusLoading.value) {
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        );
      }
      return Container();
    });
  }

  Widget _buildBodyWidget() {
    return Container(
      height: Get.height,
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppDimens.spacingNormal),
            Text(
              'Select Specialized',
              style: AppTextStyle.color3C3A36S18W500,
            ),
            const SizedBox(height: 10),
            _buildSelectSpecializedDropdownWidget(),
            const SizedBox(height: AppDimens.spacingNormal),
            Text(
              'Select class',
              style: AppTextStyle.color3C3A36S18W500,
            ),
            const SizedBox(height: 10),
            _buildSelectClassDropdownWidget(),
            const SizedBox(height: AppDimens.spacingNormal),
            Text(
              'Select student',
              style: AppTextStyle.color3C3A36S18W500,
            ),
            const SizedBox(height: 10),
            _buildSelectStudentDropdownWidget(),
            const SizedBox(height: AppDimens.spacingNormal),
            Text(
              'Select time',
              style: AppTextStyle.color3C3A36S18W500,
            ),
            const SizedBox(height: 10),
            _buildSelectTimeDropdownWidget(),
            const SizedBox(height: AppDimens.spacingNormal),
            Obx(() {
              if (state.yearSchoolSelected.value == 'All') {
                return Container();
              }
              return Text('Select semester',
                  style: AppTextStyle.color3C3A36S18W500);
            }),
            Obx(() => SizedBox(
                height: (state.yearSchoolSelected.value == 'All') ? 0 : 10)),
            _buildSelectSemesterWidget(),
            Obx(() => SizedBox(
                height: (state.yearSchoolSelected.value == 'All')
                    ? 0
                    : AppDimens.spacingNormal)),
            AppLabelTextField(
              title: 'Tuition (VND)',
              titleStyle: AppTextStyle.color3C3A36S18W500,
              hintText: 'Ex: 1000000',
              hintStyle: AppTextStyle.colorGrayS18W500,
              controller: state.tuitionTextController,
              textInputType:
                  const TextInputType.numberWithOptions(decimal: true),
              // textInputFormatter: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),],
              onChange: (text) {
                // text = _formatNumber(text.replaceAll(',', ''));
                // state.tuitionTextController.text = text;
              },
            ),
            const SizedBox(
              height: 90,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSelectSemesterWidget() {
    return Obx(() {
      if (state.yearSchoolSelected.value == 'All') {
        return Container();
      }
      return Container(
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
            value: state.listSemester[state.semesterPositionSelected.value],
            hint: Text(
                (state.listPersonResponse.isNotEmpty &&
                        state.listClassResponse.isNotEmpty)
                    ? 'All'
                    : 'No data',
                style: AppTextStyle.color3C3A36S18W500),
            onChanged: (value) {
              logic.checkSemester(value as String);
            },
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimens.spacingNormal),
            ),
            dropdownWidth: Get.width - 32,
            buttonWidth: Get.width - 32,
            offset: const Offset(-11, -AppDimens.spacingNormal),
            items: state.listSemester.map((element) {
              return DropdownMenuItem(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      element,
                      style: AppTextStyle.color3C3A36S18W500,
                    ),
                    const Spacer(),
                  ],
                ),
                value: element,
              );
            }).toList()),
      );
    });
  }

  Widget _buildSelectTimeDropdownWidget() {
    return Obx(() {
      return Container(
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
          value: state.yearSchoolSelected.value,
          hint: Text(
              (state.listPersonResponse.isNotEmpty &&
                      state.listClassResponse.isNotEmpty)
                  ? 'All'
                  : 'No data',
              style: AppTextStyle.color3C3A36S18W500),
          onChanged: (value) {
            logic.checkTimeSchoolYear(value as String);
          },
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.spacingNormal),
          ),
          dropdownWidth: Get.width - 32,
          buttonWidth: Get.width - 32,
          offset: const Offset(-11, -AppDimens.spacingNormal),
          items: (state.yearSchool.isNotEmpty)
              ? state.yearSchool.map((element) {
                  return DropdownMenuItem(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Text(
                          element,
                          style: AppTextStyle.color3C3A36S18W500,
                        ),
                        const Spacer(),
                      ],
                    ),
                    value: element,
                  );
                }).toList()
              : null,
        ),
      );
    });
  }

  Widget _buildButtonSubmitWidget() {
    return GestureDetector(
      onTap: () {
        logic.submitHandler();
      },
      child: Container(
        color: AppColors.whiteColor,
        child: Container(
          margin: const EdgeInsets.only(
            bottom: 20,
            left: AppDimens.spacingNormal,
            right: AppDimens.spacingNormal,
          ),
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
    );
  }

  Widget _buildSelectStudentDropdownWidget() {
    return Obx(() {
      return Container(
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
            value: state.personResponseSelected.value.name,
            hint: Text(
                (state.listPersonResponse.isNotEmpty &&
                        state.listClassResponse.isNotEmpty)
                    ? 'All'
                    : 'No data',
                style: AppTextStyle.color3C3A36S18W500),
            onChanged: (value) {
              logic.checkPersonSelected(value as String);
            },
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimens.spacingNormal),
            ),
            dropdownWidth: Get.width - 32,
            buttonWidth: Get.width - 32,
            offset: const Offset(-11, -AppDimens.spacingNormal),
            items: (state.classResponseSelected.value.id != null)
                ? state.listPersonResponse.map((element) {
                    return DropdownMenuItem<String>(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Text(
                            element.name ?? '',
                            style: AppTextStyle.color3C3A36S18W500,
                          ),
                          const Spacer(),
                        ],
                      ),
                      value: element.name,
                    );
                  }).toList()
                : null,
          ));
    });
  }

  Widget _buildSelectClassDropdownWidget() {
    return Obx(() {
      return Container(
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
            value: state.classResponseSelected.value.name,
            hint: Text(
                (state.listClassResponse.isNotEmpty)
                    ? 'Select class'
                    : 'No data',
                style: AppTextStyle.color3C3A36S18W500),
            onChanged: (value) {
              logic.checkClassSelected(value as String);
            },
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimens.spacingNormal),
            ),
            dropdownWidth: Get.width - 32,
            buttonWidth: Get.width - 32,
            offset: const Offset(-11, -AppDimens.spacingNormal),
            items: (state.specializedSelected.value.id != null)
                ? state.listClassResponse.map((element) {
                    return DropdownMenuItem<String>(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Text(
                            element.name ?? '',
                            style: AppTextStyle.color3C3A36S18W500,
                          ),
                          const Spacer(),
                        ],
                      ),
                      value: element.name,
                    );
                  }).toList()
                : null,
          ));
    });
  }

  Widget _buildSelectSpecializedDropdownWidget() {
    return Obx(() {
      return Container(
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
            hint: Text(
                state.listSpecialized.isNotEmpty
                    ? 'Select specialized'
                    : 'No data',
                style: AppTextStyle.color3C3A36S18W500),
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
          ));
    });
  }

  Widget _buildAppbarWidget() {
    return Container(
      padding: const EdgeInsets.only(
          bottom: AppDimens.spacingNormal, top: AppDimens.spacingNormal),
      child: Row(
        children: [
          const SizedBox(
            width: AppDimens.spacingNormal,
          ),
          AppBackButton(eventHandler: () {
            Get.back();
          }),
          const SizedBox(width: AppDimens.spacingNormal),
          Expanded(
            child: Text(
              "Tuition manager",
              style: AppTextStyle.colorDarkS24W500,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: AppDimens.spacingNormal,
          ),
        ],
      ),
    );
  }
}
