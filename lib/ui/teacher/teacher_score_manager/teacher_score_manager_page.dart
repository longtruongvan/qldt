import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/ui/teacher/teacher_score_manager/teacher_score_manager_logic.dart';

import '../../../common/app_dimens.dart';
import '../../../common/app_text_style.dart';
import '../../widgets/button/back_button.dart';

class TeacherScoreManagerPage extends StatefulWidget {
  const TeacherScoreManagerPage({Key? key}) : super(key: key);

  @override
  State<TeacherScoreManagerPage> createState() =>
      _TeacherScoreManagerPageState();
}

class _TeacherScoreManagerPageState extends State<TeacherScoreManagerPage> {
  final logic = Get.put(TeacherScoreManagerLogic());
  final state = Get.find<TeacherScoreManagerLogic>().state;

  @override
  void dispose() {
    Get.delete<TeacherScoreManagerLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: _buildAppbarWidget(),
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildBodyWidget(),
            _buildButtonSubmitWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonSubmitWidget() {
    return Positioned(
      child: Obx(() => Container(
            color: AppColors.whiteColor,
            child: GestureDetector(
              onTap: () {
                logic.clickButtonNextHandler();
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: (state.spec1Active.value &&
                            state.spec2Active.value &&
                            state.spec4Active.value)
                        ? AppColors.primaryColor
                        : AppColors.grayColor,
                    borderRadius: BorderRadius.circular(20)),
                height: 60,
                child: Center(
                    child: Text(
                  "Next",
                  style: AppTextStyle.colorWhiteS16
                      .copyWith(fontWeight: FontWeight.w500),
                )),
              ),
            ),
          )),
      left: AppDimens.spacingNormal,
      right: AppDimens.spacingNormal,
      bottom: AppDimens.spacingNormal,
    );
  }

  Widget _buildBodyWidget() {
    return Container(
      margin: const EdgeInsets.only(
          left: AppDimens.spacingNormal,
          right: AppDimens.spacingNormal,
          bottom: 100),
      child: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: AppDimens.spacingNormal),
          _buildSpecWidget(),
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
          Text(
            'Select subject',
            style: AppTextStyle.color3C3A36S18W500,
          ),
          const SizedBox(height: 10),
          _buildSelectSubjectDropdownWidget(),
        ],
      ),
    );
  }

  Widget _buildSelectSubjectDropdownWidget() {
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
          value: state.subjectResponseSelected.value.name,
          hint: Text(
              (state.specializedSelected.value.id != null &&
                      state.listSubjectResponse.isNotEmpty)
                  ? 'Select subject'
                  : 'No data',
              style: AppTextStyle.color3C3A36S18W500),
          onChanged: (value) {
            logic.checkSubjectSelected(value as String);
          },
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.spacingNormal),
          ),
          dropdownWidth: Get.width - 32,
          buttonWidth: Get.width - 32,
          offset: const Offset(-11, -AppDimens.spacingNormal),
          items: (state.listSubjectResponse.isNotEmpty &&
                  state.specializedSelected.value.id != null)
              ? state.listSubjectResponse.map((element) {
                  return DropdownMenuItem(
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
        ),
      );
    });
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

  Widget _buildSpecWidget() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: (state.spec1Active.value)
                  ? AppColors.successColor
                  : AppColors.grayColor,
            ),
            const SizedBox(
              width: 3,
            ),
            Container(
              width: 10,
              color: (state.spec2Active.value)
                  ? AppColors.successColor
                  : AppColors.grayColor,
              height: 1,
            ),
            Icon(
              Icons.check_circle,
              color: (state.spec2Active.value)
                  ? AppColors.successColor
                  : AppColors.grayColor,
            ),
            const SizedBox(
              width: 3,
            ),
            Container(
              width: 10,
              color: (state.spec3Active.value)
                  ? AppColors.successColor
                  : AppColors.grayColor,
              height: 1,
            ),
            Icon(
              Icons.check_circle,
              color: (state.spec3Active.value)
                  ? AppColors.successColor
                  : AppColors.grayColor,
            ),
            const SizedBox(
              width: 3,
            ),
            Container(
              width: 10,
              color: (state.spec4Active.value)
                  ? AppColors.successColor
                  : AppColors.grayColor,
              height: 1,
            ),
            Icon(
              Icons.check_circle,
              color: (state.spec4Active.value)
                  ? AppColors.successColor
                  : AppColors.grayColor,
            ),
          ],
        ));
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: AppDimens.spacingNormal),
          child: Row(
            children: [
              const SizedBox(
                width: AppDimens.spacingNormal,
              ),
              AppBackButton(eventHandler: () {
                Get.back();
              }),
              const SizedBox(width: AppDimens.spacingNormal),
              Text(
                "Score manager",
                style: AppTextStyle.colorDarkS24W500,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  logic.clearHandler();
                },
                child: Text(
                  "Clear",
                  style: AppTextStyle.colorDarkS16W500
                      .copyWith(color: AppColors.primaryColor),
                ),
              ),
              const SizedBox(
                width: AppDimens.spacingNormal,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimens.spacingNormal),
      ],
    );
  }
}
