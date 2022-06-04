import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/model/response/person_response.dart';
import 'package:qldt/ui/teacher/tuition/detail_tution/detail_tuition_page.dart';
import 'package:qldt/ui/teacher/tuition/search_tution/search_tuition_logic.dart';
import 'package:qldt/ui/teacher/tuition/tuition_logic.dart';

import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../widgets/button/back_button.dart';

class SearchTuitionPage extends StatefulWidget {
  const SearchTuitionPage({Key? key}) : super(key: key);

  @override
  State<SearchTuitionPage> createState() => _SearchTuitionPageState();
}

class _SearchTuitionPageState extends State<SearchTuitionPage> {
  final logic = Get.put(SearchTuitionLogic());
  final state = Get.find<SearchTuitionLogic>().state;

  @override
  void dispose() {
    Get.delete<SearchTuitionLogic>();
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
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Container(
      height: Get.height,
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
      child: SingleChildScrollView(
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
          ],
        ),
      ),
    );
  }

  Widget _buildButtonSubmitWidget() {
    return GestureDetector(
      onTap: () {
        List<PersonResponse> list = [];
        if (state.personResponseSelected.value.id != null) {
          list.add(state.personResponseSelected.value);
        } else {
          list.addAll(state.listPersonResponse);
        }
        Get.to(DetailTuitionPage(personResponse: list));
      },
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
          style:
              AppTextStyle.colorWhiteS16.copyWith(fontWeight: FontWeight.w500),
        )),
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
          Text(
            "Tuition manager",
            style: AppTextStyle.colorDarkS24W500,
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.add_circle,
              color: AppColors.successColor,
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
