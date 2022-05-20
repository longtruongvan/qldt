import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/ui/teacher/exam_schedule/add/add_exam_schedule_logic.dart';
import 'package:qldt/ui/widgets/textfields/app_text_field.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../widgets/button/back_button.dart';

class CreateExamSchedulePage extends StatefulWidget {
  const CreateExamSchedulePage({Key? key}) : super(key: key);

  @override
  State<CreateExamSchedulePage> createState() => _CreateExamSchedulePageState();
}

class _CreateExamSchedulePageState extends State<CreateExamSchedulePage> {
  final logic = Get.put(CreateExamScheduleLogic());
  final state = Get.find<CreateExamScheduleLogic>().state;

  @override
  void dispose() {
    Get.delete<CreateExamScheduleLogic>();
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
            _buildSubmitButtonWidget(),
            _buildLoadingWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButtonWidget() {
    return Positioned(
      child: InkWell(
        onTap: () {
          logic.submit();
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
      bottom: AppDimens.spacingNormal,
      left: AppDimens.spacingNormal,
      right: AppDimens.spacingNormal,
    );
  }

  Widget _buildLoadingWidget() {
    return Obx(() => Visibility(
          child: const Center(
            child: CircularProgressIndicator(),
          ),
          visible: state.stateLoading.value,
        ));
  }

  Widget _buildBodyWidget() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(AppDimens.spacingNormal),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title', style: AppTextStyle.color3C3A36S18W500),
              const SizedBox(height: 10),
              AppTextField(
                controller: state.titleTextController,
                enableSuggestions: false,
                hintText: 'Ex: Thi cuoi ky',
                hintStyle: AppTextStyle.colorGrayS18W500,
                textStyle: AppTextStyle.color3C3A36S18W500,
              ),
              const SizedBox(height: AppDimens.spacingNormal,),
              Text('Specialized', style: AppTextStyle.color3C3A36S18W500),
              const SizedBox(height: 10),
              _buildWidgetSelectSpecialized(),
              const SizedBox(height: AppDimens.spacingNormal,),
              Text('Class', style: AppTextStyle.color3C3A36S18W500),
              const SizedBox(height: 10),
              _buildWidgetSelectClass(),
              const SizedBox(height: AppDimens.spacingNormal,),
              Text('Subject', style: AppTextStyle.color3C3A36S18W500),
              const SizedBox(height: 10),
              _buildWidgetSelectSubject(),
              const SizedBox(height: AppDimens.spacingNormal,),
              Text('Type exam', style: AppTextStyle.color3C3A36S18W500),
              const SizedBox(height: 10),
              _buildWidgetSelectTypeExam(),
              const SizedBox(height: AppDimens.spacingNormal,),
              Text('Time start', style: AppTextStyle.color3C3A36S18W500),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: (){
                  _selectTime(context,(timeOfDay){
                    var x=timeOfDay.format(context);
                    state.timeStartTextController.text = x;
                  });
                },
                child: AppTextField(
                  controller: state.timeStartTextController,
                  hintText: '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
                  hintStyle: AppTextStyle.colorGrayS18W500,
                  textStyle: AppTextStyle.color3C3A36S18W500,
                  isEnable: false,
                ),
              ),
              const SizedBox(height: AppDimens.spacingNormal,),
              Text('Time end', style: AppTextStyle.color3C3A36S18W500),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: (){
                  _selectTime(context,(timeOfDay){
                    var x=timeOfDay.format(context);
                    state.timeEndTextController.text = x;
                  });
                },
                child: AppTextField(
                  controller: state.timeEndTextController,
                  hintText: '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
                  hintStyle: AppTextStyle.colorGrayS18W500,
                  textStyle: AppTextStyle.color3C3A36S18W500,
                  isEnable: false,
                ),
              ),
              const SizedBox(height: AppDimens.spacingNormal,),
              Text('Location', style: AppTextStyle.color3C3A36S18W500),
              const SizedBox(height: 10),
              AppTextField(
                controller: state.locationTextController,
                hintText: 'DH CN GTVT',
                hintStyle: AppTextStyle.colorGrayS18W500,
                textStyle: AppTextStyle.color3C3A36S18W500,
              ),
              const SizedBox(height: AppDimens.spacingNormal,),
              const SizedBox(height: AppDimens.spacingNormal,),
              const SizedBox(height: AppDimens.spacingNormal,),
              const SizedBox(height: AppDimens.spacingNormal,),
            ],
          ),
        ),
      ),
    );
  }

  Future _selectTime(BuildContext context,Function(TimeOfDay) callback) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: state.selectedTime.value,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if(timeOfDay != null && timeOfDay != state.selectedTime.value)
    {
      callback(timeOfDay);
    }
  }

  Widget _buildWidgetSelectTypeExam(){
    return Obx(() => Container(
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
        value: state.typeExamSelected.value.name,
        hint: Text('Select type exam',
            style: AppTextStyle.colorGrayS18W500),
        onChanged: (value) {
          logic.checkTypeExamSelected(value as String);
        },
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.spacingNormal),
        ),
        dropdownWidth: Get.width - 32,
        buttonWidth: Get.width - 32,
        offset: const Offset(-11, -AppDimens.spacingNormal),
        items: state.listTypeExam.map((element) {
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
        }).toList(),
      ),
    ));
  }

  Widget _buildWidgetSelectSubject(){
    return Obx(() => Container(
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
        value: state.subjectSelected.value.name,
        hint: Text('Select subject',
            style: AppTextStyle.colorGrayS18W500),
        onChanged: (value) {
          logic.checkSubjectSelected(value as String);
        },
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.spacingNormal),
        ),
        dropdownWidth: Get.width - 32,
        buttonWidth: Get.width - 32,
        offset: const Offset(-11, -AppDimens.spacingNormal),
        items: state.listSubject.map((element) {
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
        }).toList(),
      ),
    ));
  }

  Widget _buildWidgetSelectClass(){
    return Obx(() => Container(
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
        value: state.classSelected.value.name,
        hint: Text('Select class',
            style: AppTextStyle.colorGrayS18W500),
        onChanged: (value) {
          logic.checkClassSelected(value as String);
        },
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.spacingNormal),
        ),
        dropdownWidth: Get.width - 32,
        buttonWidth: Get.width - 32,
        offset: const Offset(-11, -AppDimens.spacingNormal),
        items: state.listClassResponse.map((element) {
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
        }).toList(),
      ),
    ));
  }

  Widget _buildWidgetSelectSpecialized(){
    return Obx(() => Container(
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
    ));
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
        Expanded(
          child: Text(
            "Create exam schedule",
            style: AppTextStyle.colorDarkS24W500,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          width: AppDimens.spacingNormal,
        ),
      ],
    );
  }
}
