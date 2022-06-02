import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_dimens.dart';
import 'package:qldt/common/app_text_style.dart';
import 'package:qldt/ui/student/timetable/time_table_logic.dart';
import 'package:table_calendar/table_calendar.dart';

class TimeTablePage extends StatefulWidget {
  const TimeTablePage({Key? key}) : super(key: key);

  @override
  State<TimeTablePage> createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
  final logic = Get.put(TimeTableLogic());
  final state = Get.find<TimeTableLogic>().state;

  @override
  void dispose() {
    Get.delete<TimeTableLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Obx(
                () => Container(
                  padding: const EdgeInsets.all(AppDimens.spacingNormal),
                  child: TableCalendar(
                    focusedDay: state.focusDay.value,
                    daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                            ) ??
                            TextStyle(),
                        weekendStyle: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                            ) ??
                            TextStyle()),
                    calendarStyle: const CalendarStyle(
                      outsideDaysVisible: true,
                      defaultTextStyle: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ) ??
                          TextStyle(),
                      outsideTextStyle: TextStyle(
                            color: AppColors.whiteColor,
                          ) ??
                          TextStyle(),
                      disabledTextStyle: TextStyle(
                            color: AppColors.whiteColor,
                          ) ??
                          TextStyle(),
                      weekendTextStyle: TextStyle(
                            color: Colors.white,
                          ) ??
                          TextStyle(),
                      selectedDecoration: BoxDecoration(
                        border: Border.fromBorderSide(
                          BorderSide(color: Color(0xFF9FA8DA), width: 1),
                        ),
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ) ??
                          TextStyle(),
                    ),
                    firstDay: DateTime(DateTime.now().year - 1, 1, 1),
                    lastDay: DateTime(
                        DateTime.now().year, DateTime.now().month + 1, 30),
                    calendarFormat: CalendarFormat.month,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    headerVisible: false,
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                      CalendarFormat.week: 'Week',
                    },
                    selectedDayPredicate: (date) {
                      // return date.isAtSameMomentAs(DateTime.now());
                      return isSameDay(state.focusDay.value, date);
                    },
                    onPageChanged: (focusDay) {
                      logic.changeMonth(focusDay);
                    },
                    onDaySelected: (selectedDay, focusDay) {
                      logic.changeDay(focusDay);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(AppDimens.spacingNormal),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: AppColors.whiteColor,
                  ),
                  child: Obx(() {
                    if (state.stateLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      );
                    }

                    if (state.currentListCourse.isEmpty) {
                      return Center(
                        child: Text(
                          "You don't have any class today 😅",
                          style: AppTextStyle.color3C3A36S16W500,
                        ),
                      );
                    }
                    return SingleChildScrollView(
                      child: Table(
                        border: const TableBorder(
                          horizontalInside: BorderSide(
                            width: 0.5,
                            color: AppColors.primaryColor,
                            style: BorderStyle.solid,
                          ),
                          verticalInside: BorderSide(
                            width: 0.5,
                            color: AppColors.primaryColor,
                            style: BorderStyle.solid,
                          ),
                        ),
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(7),
                        },
                        children: state.currentListCourse
                            .map(
                              (element) => _buildItemLesson(
                                '${element.subjectRegisterRequest?.propossedTime?.period ?? 1}',
                                'Subject :${element.subjectResponse?.name}',
                                'Period: ${element.subjectRegisterRequest?.propossedTime?.period}',
                                'NumberOfPeriod: ${element.subjectRegisterRequest?.propossedTime?.numberOfPeriod}',
                              ),
                            )
                            .toList(),
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildItemLesson(String lesson, String name, String period,String numberOfPeriod) {
    return TableRow(children: [
      Container(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Text(
            'Lesson $lesson:',
            style: AppTextStyle.color3C3A36S16W500,
          )),
      Container(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: AppDimens.spacingNormal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: AppTextStyle.color3C3A36S16W500,
            ),
            Text(
              period,
              style: AppTextStyle.color3C3A36S16W500,
            ),
            Text(
              numberOfPeriod,
              style: AppTextStyle.color3C3A36S16W500,
            )
          ],
        ),
      ),
    ]);
  }
}
