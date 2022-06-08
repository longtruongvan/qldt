import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/model/request/subject_register_request.dart';
import 'package:qldt/ui/teacher/student_register/create_time_table/create_time_table_logic.dart';

import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/entity/course_entity.dart';
import '../../../widgets/button/back_button.dart';

class CreateTimeTablePage extends StatefulWidget {
  final String title;
  final List<CourseEntity> listCourseEntity;
  final Function() callback;

  const CreateTimeTablePage({
    Key? key,
    required this.title,
    required this.listCourseEntity,
    required this.callback,
  }) : super(key: key);

  @override
  State<CreateTimeTablePage> createState() => _CreateTimeTablePageState();
}

class _CreateTimeTablePageState extends State<CreateTimeTablePage> {
  final logic = Get.put(CreateTimeTableLogic());
  final state = Get.find<CreateTimeTableLogic>().state;

  @override
  void dispose() {
    Get.delete<CreateTimeTableLogic>();
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
            _buildBodyWidget(),
            _buildLoadingWidget(),
          ],
        ),
      ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppDimens.spacingNormal,
        ),
        _buildAppbarWidget(),
        const SizedBox(
          height: AppDimens.spacingNormal,
        ),
        Container(
          margin:
              const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
          child: Text(
            S.of(context).create_time_table_select_day,
            style: AppTextStyle.color3C3A36S18W500,
          ),
        ),
        const SizedBox(
          height: AppDimens.spacingNormal,
        ),
        Container(
          height: 50,
          child: Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.spacingNormal),
              scrollDirection: Axis.horizontal,
              itemBuilder: (c, index) {
                return GestureDetector(
                  onTap: () {
                    logic.checkLessonInDayOffWeek(index);
                  },
                  child: Container(
                    height: 50,
                    width: 70,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      border: Border.all(color: AppColors.grayColor, width: 1),
                      color: (state.listDayOfWeek[index].isSelected ?? false)
                          ? AppColors.primaryColor
                          : AppColors.whiteColor,
                    ),
                    child: Text(
                      state.listDayOfWeek[index].day ?? '',
                      style: TextStyle(
                        color: (state.listDayOfWeek[index].isSelected ?? false)
                            ? AppColors.whiteColor
                            : AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
              itemCount: state.listDayOfWeek.length,
            );
          }),
        ),
        const SizedBox(
          height: AppDimens.spacingNormal,
        ),
        Container(
          margin:
              const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
          child: Text(
            S.of(context).create_time_table_select_lesson,
            style: AppTextStyle.color3C3A36S18W500,
          ),
        ),
        _buildListSelectLessonWidget(),
        _buildButtonSubmitWidget(),
      ],
    );
  }

  Widget _buildButtonSubmitWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
      color: AppColors.whiteColor,
      child: GestureDetector(
        onTap: () {
          logic.submit(widget.listCourseEntity,(){
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
            S.current.common_ok,
            style: AppTextStyle.colorWhiteS16
                .copyWith(fontWeight: FontWeight.w500),
          )),
        ),
      ),
    );
  }

  Widget _buildListSelectLessonWidget() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.all(0),
          itemBuilder: (c, index) {
            return _buildItemLessonWidget(index);
          },
          itemCount: state.listLesson.length,
          shrinkWrap: true,
        );
      }),
    );
  }

  Widget _buildItemLessonWidget(int index) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(AppDimens.spacingNormal),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.grayColor, width: 1),
      ),
      margin: const EdgeInsets.all(AppDimens.spacingNormal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '* ${state.listLesson[index].dayOffWeek}',
            style: AppTextStyle.color3C3A36S18W500.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _buildListLessonItemWidget(index)
        ],
      ),
    );
  }

  Widget _buildListLessonItemWidget(int index) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, position) {
          return GestureDetector(
            onTap: () {
              state.listLesson[index].dataLesson[position].isSelected =
                  !(state.listLesson[index].dataLesson[position].isSelected ??
                      false);
              state.listLesson.refresh();
            },
            child: Container(
              width: 50,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                border: Border.all(color: AppColors.grayColor, width: 1),
                color:
                    (state.listLesson[index].dataLesson[position].isSelected ??
                            false)
                        ? AppColors.primaryColor
                        : AppColors.whiteColor,
              ),
              child: Text(
                state.listLesson[index].dataLesson[position].lesson ?? '',
                style: TextStyle(
                  color: (state.listLesson[index].dataLesson[position]
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
        itemCount: state.listLesson[index].dataLesson.length,
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
            widget.title,
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
