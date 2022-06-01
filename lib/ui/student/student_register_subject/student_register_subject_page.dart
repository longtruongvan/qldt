import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_images.dart';
import 'package:qldt/ui/student/student_register_subject/student_register_subject_logic.dart';

import '../../../common/app_dimens.dart';
import '../../../common/app_text_style.dart';
import '../../widgets/button/back_button.dart';

class StudentRegisterSubjectPage extends StatefulWidget {
  final Function() callback;

  const StudentRegisterSubjectPage({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  State<StudentRegisterSubjectPage> createState() =>
      _StudentRegisterSubjectPageState();
}

class _StudentRegisterSubjectPageState
    extends State<StudentRegisterSubjectPage> {
  final logic = Get.put(StudentRegisterSubjectLogic());
  final state = Get.find<StudentRegisterSubjectLogic>().state;

  @override
  void dispose() {
    Get.delete<StudentRegisterSubjectLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
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
            _buildButtonSubjectSelectedWidget(),
            _buildLoadingWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonSubjectSelectedWidget() {
    return Positioned(
      bottom: 120,
      right: AppDimens.spacingNormal,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        elevation: 10,
        child: SizedBox(
          height: 75,
          width: 70,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: AppColors.darkColor, width: 1),
                  ),
                  child: Image.asset(
                    AppImages.icSubjectSelected,
                    width: 24,
                    height: 24,
                  ),
                  width: 70,
                  height: 70,
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  alignment: Alignment.center,
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25)),
                  child: Obx(
                    () => Text(
                      '${state.countSubjectSelected.value}',
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonSubmitWidget() {
    return Positioned(
      child: Container(
        color: AppColors.whiteColor,
        child: GestureDetector(
          onTap: () {
            logic.clickNextButton((){
              widget.callback();
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
              "Next",
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
    return Container(
      padding: const EdgeInsets.all(AppDimens.spacingNormal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSelectSpecializedWidget(),
          const SizedBox(
            height: AppDimens.spacingNormal,
          ),
          Text('List subjects', style: AppTextStyle.color3C3A36S18W500),
          const SizedBox(
            height: AppDimens.spacingNormal,
          ),
          _buildListSubject(),
        ],
      ),
    );
  }

  Widget _buildListSubject() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          itemBuilder: (c, index) {
            return Container(
              padding: const EdgeInsets.all(AppDimens.spacingNormal),
              child: Row(
                children: [
                  Image.asset(
                    state.listSubject[index].icon ?? AppImages.icSpecialized6,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(state.listSubject[index].name ?? '',
                        style: AppTextStyle.color3C3A36S18W500),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      logic.selectSubject(index);
                    },
                    child: Icon(
                      (state.listSubject[index].isSelected ?? false)
                          ? Icons.check_circle
                          : Icons.add_circle,
                      color: Colors.green,
                    ),
                  )
                ],
              ),
            );
          },
          itemCount: state.listSubject.length,
        ));
  }

  Widget _buildSelectSpecializedWidget() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: AppDimens.spacingNormal,
          ),
          Text('Specialized', style: AppTextStyle.color3C3A36S18W500),
          const SizedBox(height: 10),
          Container(
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
              hint: Text('Select specialized',
                  style: AppTextStyle.colorGrayS18W500),
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
        ],
      ),
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
          "Register subject",
          style: AppTextStyle.colorDarkS24W500,
        ),
        const SizedBox(
          width: AppDimens.spacingNormal,
        ),
      ],
    );
  }
}
