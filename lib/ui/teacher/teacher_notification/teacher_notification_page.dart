import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qldt/common/app_dimens.dart';
import 'package:qldt/ui/teacher/teacher_notification/teacher_notification_logic.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_text_style.dart';

class TeacherNotificationPage extends StatefulWidget {
  const TeacherNotificationPage({Key? key}) : super(key: key);

  @override
  State<TeacherNotificationPage> createState() =>
      _TeacherNotificationPageState();
}

class _TeacherNotificationPageState extends State<TeacherNotificationPage> {
  final logic = Get.put(TeacherNotificationLogic());
  final state = Get.find<TeacherNotificationLogic>().state;

  @override
  void dispose() {
    Get.delete<TeacherNotificationLogic>();
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildBodyWidget(),
          _buildLoadingWidget(),
        ],
      ),
    );
  }

  Widget _buildBodyWidget(){
    return Container(
      padding: const EdgeInsets.all(AppDimens.spacingNormal),
      color: AppColors.whiteColor,
      child: SafeArea(
        child: Obx(() {
          return RefreshIndicator(
              child: ListView.builder(
                itemBuilder: (c, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 3,
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding:
                        const EdgeInsets.all(AppDimens.spacingNormal),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              state.listNotification[index].title ?? '',
                              style: AppTextStyle.colorDarkS16W500,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.parse((state.listNotification[index].time ?? ''))),
                              style: AppTextStyle.colorGrayS14W500,
                            ),
                          ],
                        )),
                  );
                },
                itemCount: state.listNotification.length,
              ),
              onRefresh: _onRefresh);
        }),
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

  Future _onRefresh() async {
    logic.fetchData();
  }

  Widget _buildAppbarWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Notifications",
          style: AppTextStyle.colorDarkS24W500,
        )
      ],
    );
  }
}
