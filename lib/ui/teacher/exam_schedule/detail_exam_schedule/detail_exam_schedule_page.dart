import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/ui/teacher/exam_schedule/detail_exam_schedule/detail_exam_schedule_logic.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/response/example_schedule_response.dart';
import '../../../widgets/button/back_button.dart';

class DetailExamSchedulePage extends StatefulWidget {
  final ExampleScheduleResponse exampleScheduleResponse;

  const DetailExamSchedulePage({
    Key? key,
    required this.exampleScheduleResponse,
  }) : super(key: key);

  @override
  State<DetailExamSchedulePage> createState() => _DetailExamSchedulePageState();
}

class _DetailExamSchedulePageState extends State<DetailExamSchedulePage> {
  final logic = Get.put(DetailExamScheduleLogic());
  final state = Get.find<DetailExamScheduleLogic>().state;

  @override
  void initState() {
    logic.fetchData(widget.exampleScheduleResponse);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<DetailExamScheduleLogic>();
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
              Obx(() => Table(
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
                      _buildRowTableWidget(
                          S.of(context).detail_exam_title, '${widget.exampleScheduleResponse.title}'),
                      _buildRowTableWidget(S.of(context).detail_exam_subject,
                          '${state.detailExamEntity.value.subjectResponse?.name ?? widget.exampleScheduleResponse.subjectId}'),
                      _buildRowTableWidget(S.of(context).detail_exam_time,
                          '${widget.exampleScheduleResponse.timeStart} - ${widget.exampleScheduleResponse.timeEnd}'),
                      _buildRowTableWidget(S.of(context).detail_exam_day,
                          '${state.detailExamEntity.value.timeFormat ?? widget.exampleScheduleResponse.dayStart}'),
                      // _buildRowTableWidget(
                      //     'Class', widget.exampleScheduleResponse.idClass ?? ''),
                      _buildRowTableWidget(S.of(context).detail_exam_description,
                          widget.exampleScheduleResponse.description ?? ''),
                    ],
                  )),
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

  TableRow _buildRowTableWidget(String title, String value) {
    return TableRow(children: [
      Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
        child: Text(
          title,
          style: AppTextStyle.colorDarkS16W500,
          maxLines: 1,
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
        child: Text(
          value,
          style: AppTextStyle.colorDarkS16W500,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
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
            S.of(context).detailExamSchedule,
            style: AppTextStyle.colorDarkS24W500,
          ),
        ),
      ],
    );
  }
}
