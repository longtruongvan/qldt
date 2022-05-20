import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/ui/teacher/exam_schedule/add/add_exam_schedule_page.dart';
import 'package:qldt/ui/teacher/exam_schedule/exam_schedule_logic.dart';
import 'package:qldt/ui/teacher/exam_schedule/exam_schedule_state.dart';
import 'package:qldt/ui/teacher/exam_schedule/list_exam/list_exam_page.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../common/app_dimens.dart';
import '../../../common/app_text_style.dart';
import '../../widgets/button/back_button.dart';

class ExamSchedulePage extends StatefulWidget {
  const ExamSchedulePage({Key? key}) : super(key: key);

  @override
  State<ExamSchedulePage> createState() => _ExamSchedulePageState();
}

class _ExamSchedulePageState extends State<ExamSchedulePage> {
  final logic = Get.put(ExamScheduleLogic());
  final state = Get.find<ExamScheduleLogic>().state;

  @override
  void dispose() {
    Get.delete<ExamScheduleLogic>();
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
        child: SafeArea(
          child: Column(
            children: [
              Obx(() => TableCalendar(
                    focusedDay: state.focusDay.value,
                    firstDay: DateTime(DateTime.now().year - 1, 1, 1),
                    lastDay: DateTime.now(),
                    calendarFormat: CalendarFormat.month,
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                      CalendarFormat.week: 'Week',
                    },
                    selectedDayPredicate: (date) {
                      return date.isAtSameMomentAs(DateTime.now());
                    },
                    onDaySelected: (selectedDay, focusDay) {
                      // state.focusDay.value = focusDay;
                      // state.focusDay.refresh();
                    },
                  )),
              const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(const CreateExamSchedulePage());
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        elevation: 2,
                        child: Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grayColor,width: 1,),
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Text('Create exam schedule',style: AppTextStyle.color3C3A36S18W500.copyWith(color: AppColors.primaryColor),),
                              const Spacer(),
                              const Icon(Icons.navigate_next_sharp)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(const ListExamPage());
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        elevation: 2,
                        child: Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grayColor,width: 1,),
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Text('List of exam schedule',style: AppTextStyle.color3C3A36S18W500.copyWith(color: AppColors.primaryColor),),
                              const Spacer(),
                              const Icon(Icons.navigate_next_sharp)
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),

            ],
          ),
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
            "Exam schedule",
            style: AppTextStyle.colorDarkS24W500,
          ),
        ),
        const SizedBox(
          width: AppDimens.spacingNormal,
        ),
        DropdownButton<String>(
          items: <String>['Create'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyle.colorDarkS16W500,
              ),
            );
          }).toList(),
          onChanged: (_) {
            if (_ == 'Create') {
              Get.to(const CreateExamSchedulePage());
              // _showDialogDelete();
            }
          },
          icon: const Icon(Icons.more_vert),
          underline: Container(),
        ),
        const SizedBox(
          width: AppDimens.spacingNormal,
        ),
      ],
    );
  }
}
