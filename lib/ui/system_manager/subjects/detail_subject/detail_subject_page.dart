import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/model/response/subject_response.dart';
import 'package:qldt/ui/system_manager/subjects/detail_subject/detail_subject_logic.dart';

import '../../../../common/app_dimens.dart';
import '../../../../common/app_images.dart';
import '../../../../common/app_text_style.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/button/back_button.dart';
import '../../../widgets/textfields/app_label_text_field.dart';

class DetailSubjectPage extends StatefulWidget {
  final SubjectResponse subjectResponse;
  final Function(SubjectResponse) callback;

  const DetailSubjectPage({
    Key? key,
    required this.subjectResponse,
    required this.callback,
  }) : super(key: key);

  @override
  State<DetailSubjectPage> createState() => _DetailSubjectPageState();
}

class _DetailSubjectPageState extends State<DetailSubjectPage> {
  final logic = Get.put(DetailSubjectLogic());
  final state = Get.find<DetailSubjectLogic>().state;

  @override
  void initState() {
    super.initState();
    logic.initData(widget.subjectResponse);
  }

  @override
  void dispose() {
    Get.delete<DetailSubjectLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 1,
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
            _buildSubmitButtonWidget(),
            _buildLoadingWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectSpecializedWidget() {
    return Obx(
      () {
        if (!state.isEdit.value) {
          return _buildInfoItemRow(
            tile: 'Specialized',
            hint: 'Ex: Cntt',
            controller: state.nameSpecializedTextController,
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
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
            )
          ],
        );
      },
    );
  }

  Widget _buildSubmitButtonWidget() {
    return Obx(() => Visibility(
          child: Positioned(
            child: InkWell(
              onTap: () {
                logic.updateSubject(widget.subjectResponse, (response) {
                  widget.callback(response);
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
            bottom: AppDimens.spacingNormal,
            left: AppDimens.spacingNormal,
            right: AppDimens.spacingNormal,
          ),
          visible: state.isEdit.value,
        ));
  }

  Widget _buildLoadingWidget() {
    return Obx(
      () => Center(
        child: Visibility(
          visible: state.stateLoading.value,
          child: const CircularProgressIndicator(),
        ),
      ),
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
            _buildSelectSpecializedWidget(),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            Obx(() => _buildInfoItemRow(
                  tile: S.of(context).common_name_subject,
                  hint: 'Ex: Flutter',
                  controller: state.nameSubjectTextController,
                )),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            Obx(() => _buildInfoItemRow(
                  tile: 'Code subject',
                  hint: 'Ex: Flutter2022',
                  controller: state.codeSubjectTextController,
                )),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            Obx(() => _buildInfoItemRow(
                  tile: 'Number of lesson',
                  hint: 'Ex: 60',
                  controller: state.numberOfLessonTextController,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItemRow({
    required String tile,
    required String hint,
    required TextEditingController controller,
  }) {
    return AppLabelTextField(
      title: tile,
      hintText: hint,
      titleStyle: AppTextStyle.colorDarkS16W500,
      hintStyle: AppTextStyle.colorGrayS14W500,
      controller: controller,
      spacingTitleAndTextField: 10,
      textInputAction: TextInputAction.next,
      isEnable: state.isEdit.value,
    );
  }

  Widget _buildAppbarWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(
              width: AppDimens.spacingNormal,
            ),
            AppBackButton(eventHandler: () {
              Get.back();
            }),
            const SizedBox(width: AppDimens.spacingNormal),
            Image.asset(
              widget.subjectResponse.icon ?? AppImages.icSpecialized1,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "${widget.subjectResponse.name}",
                style: AppTextStyle.colorDarkS24W500,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            DropdownButton<String>(
              items: <String>['Update', 'Delete'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: AppTextStyle.colorDarkS16W500,
                  ),
                );
              }).toList(),
              onChanged: (_) {
                if (_ == 'Delete') {
                  _showDialogDelete();
                } else {
                  state.isEdit.value = true;
                }
              },
              icon: const Icon(Icons.more_vert),
              underline: Container(),
            ),
            const SizedBox(
              width: AppDimens.spacingNormal,
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _showDialogDelete() {
    showDialog(
        context: context,
        builder: (BuildContext c) {
          return AlertDialog(
            title: Text(
              'Notification',
              style: AppTextStyle.colorDarkS20W500,
            ),
            content: Text(
              'Do you want to delete subject. Please confirm',
              style: AppTextStyle.colorDarkS16W500,
            ),
            actions: [
              FlatButton(
                child: Text(
                  'Cancel',
                  style: AppTextStyle.colorPrimaryS16,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              FlatButton(
                child: Text(
                  'OK',
                  style: AppTextStyle.colorPrimaryS16,
                ),
                onPressed: () {
                  logic.deleteSubject(widget.subjectResponse.id ?? '');
                },
              ),
            ],
          );
        });
  }
}
