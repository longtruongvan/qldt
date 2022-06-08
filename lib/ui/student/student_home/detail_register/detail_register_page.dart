import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/model/entity/course_entity.dart';
import 'package:qldt/ui/student/student_home/detail_register/detail_register_logic.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/button/back_button.dart';

class DetailRegisterPage extends StatefulWidget {
  final CourseEntity courseEntity;

  const DetailRegisterPage({
    Key? key,
    required this.courseEntity,
  }) : super(key: key);

  @override
  State<DetailRegisterPage> createState() => _DetailRegisterPageState();
}

class _DetailRegisterPageState extends State<DetailRegisterPage> {
  final logic = Get.put(DetailRegisterLogic());
  final state = Get.find<DetailRegisterLogic>().state;

  @override
  void dispose() {
    Get.delete<DetailRegisterLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAppbarWidget(),
              const SizedBox(height: AppDimens.spacingNormal),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(4),
                  1: FlexColumnWidth(6),
                },
                border: const TableBorder(
                  horizontalInside: BorderSide(
                    width: 1,
                    color: AppColors.grayColor,
                    style: BorderStyle.solid,
                  ),
                  verticalInside: BorderSide(
                    width: 1,
                    color: AppColors.grayColor,
                    style: BorderStyle.solid,
                  ),
                  top: BorderSide(
                    color: AppColors.grayColor,
                  ),
                  left: BorderSide(
                    color: AppColors.grayColor,
                  ),
                  right: BorderSide(
                    color: AppColors.grayColor,
                  ),
                  bottom: BorderSide(
                    color: AppColors.grayColor,
                  ),
                ),
                children: [
                  _buildRowTableWidget(S.of(context).course_name_course,'${widget.courseEntity.subjectResponse?.name}'),
                  _buildRowTableWidget(S.of(context).specialized,'${widget.courseEntity.specializedResponse?.name}'),
                  _buildRowTableWidget(S.of(context).course_time_payment,widget.courseEntity.subjectRegisterRequest
                      ?.timePayment ??
                      S.of(context).common_unknown),
                  _buildRowTableWidget(S.of(context).common_status,'${widget.courseEntity.subjectRegisterRequest?.isAccept}'),
                  _buildRowTableWidget(S.of(context).course_period,widget.courseEntity.subjectRegisterRequest
                      ?.propossedTime?.period ??
                      S.of(context).common_unknown),
                  _buildRowTableWidget(S.of(context).course_number_of_period,widget.courseEntity.subjectRegisterRequest
                      ?.propossedTime?.numberOfPeriod ??
                      S.of(context).common_unknown),
                ],
              ),
              const SizedBox(
                height: AppDimens.spacingNormal,
              ),
              // _buildDayOfWeekWidget(),
            ],
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
        Expanded(
          child: Text(
            S.of(context).course_detail_course,
            style: AppTextStyle.colorDarkS24W500,
          ),
        ),
      ],
    );
  }

  TableRow _buildRowTableWidget(String title,String value){
    return TableRow(children: [
      Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10,left: 10),
        child: Text(
          title,
          style: AppTextStyle.colorDarkS16W500,
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
        child: Text(
          value,
          style: AppTextStyle.colorDarkS16W500,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  }

  Widget _buildDayOfWeekWidget() {
    return SizedBox(
      height: 40,
      width: Get.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: AppDimens.spacingNormal),
        itemBuilder: (c, index) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: AppColors.successColor,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.courseEntity.subjectRegisterRequest?.propossedTime
                  ?.dayOfWeek?[index] ??
                  '',
              style: AppTextStyle.colorWhiteS14W500,
            ),
          );
        },
        itemCount: widget.courseEntity.subjectRegisterRequest
            ?.propossedTime?.dayOfWeek?.length,
      ),
    );
  }
}
