import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/model/response/specialized_response.dart';
import 'package:qldt/ui/student/student_register_subject_2/student_register_subject_next_logic.dart';
import 'package:qldt/ui/widgets/textfields/app_text_field.dart';

import '../../../common/app_dimens.dart';
import '../../../common/app_text_style.dart';
import '../../../generated/l10n.dart';
import '../../../model/response/subject_response.dart';
import '../../widgets/button/back_button.dart';

class StudentRegisterSubjectNextPage extends StatefulWidget {
  final SpecializedResponse specializedResponse;
  final List<SubjectResponse> listSubject;
  final Function() callback;

  const StudentRegisterSubjectNextPage({
    Key? key,
    required this.specializedResponse,
    required this.listSubject,
    required this.callback,
  }) : super(key: key);

  @override
  State<StudentRegisterSubjectNextPage> createState() =>
      _StudentRegisterSubjectNextPageState();
}

class _StudentRegisterSubjectNextPageState
    extends State<StudentRegisterSubjectNextPage> {
  final logic = Get.put(StudentRegisterSubjectNextLogic());
  final state = Get.find<StudentRegisterSubjectNextLogic>().state;

  @override
  void initState() {
    logic.initData(widget.listSubject, widget.specializedResponse);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<StudentRegisterSubjectNextLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppDimens.spacingNormal),
          child: _buildAppbarWidget(),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildBodyWidget(),
          _buildSubmitButtonWidget(),
          _buildLoadingWidget(),
        ],
      ),
    );
  }

  Widget _buildSubmitButtonWidget() {
    return Positioned(
      child: InkWell(
        onTap: () {
          logic.submitButtonClickListener(widget.callback);
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
      bottom: 20,
      left: AppDimens.spacingNormal,
      right: AppDimens.spacingNormal,
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
      padding: const EdgeInsets.all(AppDimens.spacingNormal),
      color: AppColors.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).list_subject,
            style: AppTextStyle.color3C3A36S18W500.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(
            height: AppDimens.spacingNormal,
          ),
          Obx(() => Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (c, index) {
                return _buildItemSubject(index);
              },
              itemCount: state.listSubjectEntity.length,
            ),
          )),
          const SizedBox(
            height: 70,
          ),
        ],
      ),
    );
  }

  Widget _buildItemSubject(int index) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            Text(
              '${S.of(context).common_name_subject}: ${widget.listSubject[index].name}',
              style: AppTextStyle.colorGrayS18W500,
            ),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            Text(
              'Number of lesson: ${widget.listSubject[index].numberOffLesson}',
              style: AppTextStyle.colorGrayS18W500,
            ),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            Text(
              '${S.of(context).specialized}: ${widget.specializedResponse.name}',
              style: AppTextStyle.colorGrayS18W500,
            ),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            Text(
              '${widget.listSubject[index].name}',
              style: AppTextStyle.color3C3A36S18W500,
            ),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            SizedBox(
              height: 50,
              child: Obx(() => ListView.builder(
                    itemBuilder: (_, position) {
                      return GestureDetector(
                        onTap: () {
                          state.listSubjectEntity[index].listDayOfWeek![position].isSelected =
                              !(state.listSubjectEntity[index].listDayOfWeek![position]
                                      .isSelected ??
                                  false);
                          state.listSubjectEntity.refresh();
                        },
                        child: Container(
                          height: 50,
                          width: 70,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            border: Border.all(
                                color: AppColors.grayColor, width: 1),
                            color: (state.listSubjectEntity[index].listDayOfWeek![position]
                                        .isSelected ??
                                    false)
                                ? AppColors.primaryColor
                                : AppColors.whiteColor,
                          ),
                          child: Text(
                            state.listSubjectEntity[index].listDayOfWeek![position].day ?? '',
                            style: TextStyle(
                              color: (state.listSubjectEntity[index].listDayOfWeek![position]
                                          .isSelected ??
                                      false)
                                  ? AppColors.whiteColor
                                  : AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: state.listSubjectEntity[index].listDayOfWeek!.length,
                    shrinkWrap: true,
                  )),
            ),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            AppTextField(
              controller: state.listSubjectEntity[index].numberOfPreiodTextController ??
                  TextEditingController(),
              hintText: S.of(context).numberOfPeriod,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              hintStyle: AppTextStyle.colorGrayS18W500,
              textStyle: AppTextStyle.color3C3A36S18W500,
            ),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            AppTextField(
              controller:
                  state.listSubjectEntity[index].preiodStartTextController ??
                      TextEditingController(),
              hintText: S.of(context).periodStart,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              hintStyle: AppTextStyle.colorGrayS18W500,
              textStyle: AppTextStyle.color3C3A36S18W500,
            ),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
          ],
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
        Expanded(
          child: Text(
            '${S.of(context).registerSubject} (${widget.listSubject.length})',
            style: AppTextStyle.colorDarkS24W500,
          ),
        ),
        const SizedBox(
          width: AppDimens.spacingNormal,
        ),
      ],
    );
  }
}
