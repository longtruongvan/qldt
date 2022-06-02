import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_images.dart';
import 'package:qldt/ui/student/student_home/list_register/list_register_logic.dart';
import 'package:qldt/ui/student/student_register_subject/student_register_subject_page.dart';

import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../widgets/button/back_button.dart';

class ListRegisterPage extends StatefulWidget {
  const ListRegisterPage({Key? key}) : super(key: key);

  @override
  State<ListRegisterPage> createState() => _ListRegisterPageState();
}

class _ListRegisterPageState extends State<ListRegisterPage> {
  final logic = Get.put(ListRegisterLogic());
  final state = Get.find<ListRegisterLogic>().state;

  @override
  void dispose() {
    Get.delete<ListRegisterLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        elevation: 1,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: _buildAppbarWidget(),
        ),
      ),
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

  Future<void> _refresh() async {
    // logic.fetchData();
  }

  Widget _buildBodyWidget() {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Obx(() => ListView.builder(
            padding: const EdgeInsets.only(top: AppDimens.spacingNormal),
            itemBuilder: (c, index) {
              return _buildItemCourse(index);
            },
            itemCount: state.listCourse.length,
          )),
    );
  }

  Widget _buildItemCourse(int index) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.primaryColor,
      ),
      width: Get.width - 72,
      child: Container(
        padding: const EdgeInsets.only(
          left: AppDimens.spacingNormal,
          top: AppDimens.spacingNormal,
          bottom: AppDimens.spacingNormal,
          right: AppDimens.spacingNormal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Table(
              columnWidths: const {
                0: FlexColumnWidth(4),
                1: FlexColumnWidth(6),
              },
              border: const TableBorder(
                horizontalInside: BorderSide(
                  width: 1,
                  color: AppColors.whiteColor,
                  style: BorderStyle.solid,
                ),
                verticalInside: BorderSide(
                  width: 1,
                  color: AppColors.whiteColor,
                  style: BorderStyle.solid,
                ),
              ),
              children: [
                TableRow(children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Name course: ',
                      style: AppTextStyle.colorWhiteS16W500,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                    child: Text(
                      '${state.listCourse[index].subjectResponse?.name}',
                      style: AppTextStyle.colorDarkS14Bold,
                    ),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Specialized',
                      style: AppTextStyle.colorWhiteS16W500,
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                    child: Text(
                      '${state.listCourse[index].specializedResponse?.name}',
                      style: AppTextStyle.colorDarkS14Bold,
                    ),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Time payment:',
                      style: AppTextStyle.colorWhiteS16W500,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                    child: Text(
                      state.listCourse[index].subjectRegisterRequest
                              ?.timePayment ??
                          'Unknown',
                      style: AppTextStyle.colorDarkS14Bold,
                    ),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Status:',
                      style: AppTextStyle.colorWhiteS16W500,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                    child: Text(
                      '${state.listCourse[index].subjectRegisterRequest?.isAccept}',
                      style: AppTextStyle.colorDarkS14Bold,
                    ),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Period:',
                      style: AppTextStyle.colorWhiteS16W500,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                    child: Text(
                      state.listCourse[index].subjectRegisterRequest
                              ?.propossedTime?.period ??
                          'Unknown',
                      style: AppTextStyle.colorDarkS14Bold,
                    ),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Number of period:',
                      style: AppTextStyle.colorWhiteS16W500,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                    child: Text(
                      state.listCourse[index].subjectRegisterRequest
                              ?.propossedTime?.numberOfPeriod ??
                          'Unknown',
                      style: AppTextStyle.colorDarkS14Bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ]),
              ],
            ),
            const SizedBox(height: AppDimens.spacingNormal,),
            _buildDayOfWeekWidget(index),
          ],
        ),
      ),
    );
  }

  Widget _buildDayOfWeekWidget(int position) {
    return SizedBox(
      height: 40,
      width: Get.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (c, index) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: AppColors.successColor,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              state.listCourse[position].subjectRegisterRequest?.propossedTime
                      ?.dayOfWeek?[index] ??
                  '',
              style: AppTextStyle.colorWhiteS14W500,
            ),
          );
        },
        itemCount: state.listCourse[position].subjectRegisterRequest
            ?.propossedTime?.dayOfWeek?.length,
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
            "Courses",
            style: AppTextStyle.colorDarkS24W500,
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Get.to(StudentRegisterSubjectPage(
                callback: () {
                  Get.back(closeOverlays: true);
                },
              ));
            },
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
