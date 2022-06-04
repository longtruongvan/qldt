import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qldt/common/app_dimens.dart';
import 'package:qldt/common/app_images.dart';
import 'package:qldt/ui/splash/splash_logic.dart';
import 'package:qldt/ui/teacher/teacher_notification/teacher_notification_logic.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_text_style.dart';

class TeacherNotificationPage extends StatefulWidget {
  final PersonType personType;

  const TeacherNotificationPage({
    Key? key,
    required this.personType,
  }) : super(key: key);

  @override
  State<TeacherNotificationPage> createState() =>
      _TeacherNotificationPageState();
}

class _TeacherNotificationPageState extends State<TeacherNotificationPage> {
  final logic = Get.put(TeacherNotificationLogic());
  final state = Get.find<TeacherNotificationLogic>().state;

  @override
  void initState() {
    logic.fetchData(widget.personType);
    super.initState();
  }

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
        backgroundColor: AppColors.primaryColor,
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

  Widget _buildBodyWidget() {
    return Container(
      color: AppColors.whiteColor,
      child: SafeArea(
        child: Obx(() {
          if (state.listNotification.isEmpty) {
            return const Center(
              child: Text('You are not have any message'),
            );
          }
          return RefreshIndicator(
            child: ListView.separated(
              itemBuilder: (c, index) {
                return GestureDetector(
                  onTap: () {
                    String targetViewType =
                        state.listNotification[index].typeNotification ??
                            'LICH_THI';
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: AppColors.primaryColor.withOpacity(0.2),
                    child: Row(
                      children: [
                        const SizedBox(width: AppDimens.spacingNormal),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: (state.listNotification[index].avatarUrl !=
                                    null)
                                ? Image.network(
                                    state.listNotification[index].avatarUrl ??
                                        '',
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    AppImages.imgUser,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(width: AppDimens.spacingNormal),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                state.listNotification[index].title ?? '',
                                style:
                                    AppTextStyle.colorDarkGrayS14W500.copyWith(
                                  fontSize: 16,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                DateFormat('hh:mm:ss - dd-MM-yyyy').format(
                                    DateTime.parse(
                                        (state.listNotification[index].time ??
                                            ''))),
                                style: AppTextStyle.colorGrayS14W500.copyWith(
                                  fontSize: 12,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppDimens.spacingNormal),
                      ],
                    ),
                  ),
                );
              },
              itemCount: state.listNotification.length,
              separatorBuilder: (c, index) {
                return const Divider(
                  height: 2,
                  color: AppColors.whiteColor,
                );
              },
            ),
            onRefresh: _onRefresh,
          );
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
    logic.fetchData(widget.personType);
  }

  Widget _buildAppbarWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: AppDimens.spacingNormal),
          Text(
            "Notifications",
            style: AppTextStyle.colorDarkS24W500.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
          const Spacer(),
          // Text(
          //   "Clear",
          //   style: AppTextStyle.colorDarkS24W500.copyWith(
          //     color: AppColors.whiteColor,
          //     fontSize: 16,
          //   ),
          // ),
          const SizedBox(width: AppDimens.spacingNormal),
        ],
      ),
    );
  }
}
