import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/services/auth_service.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/system_manager_department_manager_page.dart';
import 'package:qldt/ui/teacher/exam_schedule/exam_schedule_page.dart';
import 'package:qldt/ui/teacher/teacher_home/teacher_home_logic.dart';
import 'package:qldt/ui/teacher/teacher_main/teacher_main_logic.dart';

import '../../../common/app_dimens.dart';
import '../../../common/app_images.dart';
import '../../../common/app_text_style.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({Key? key}) : super(key: key);

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  final logic = Get.put(TeacherHomeLogic());
  final state = Get.find<TeacherHomeLogic>().state;
  final teacherMainState = Get.find<TeacherMainLogic>().state;
  final authService = Get.find<AuthService>();

  @override
  void dispose() {
    Get.delete<TeacherHomeLogic>();
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
          preferredSize: const Size.fromHeight(AppDimens.spacingNormal),
          child: _buildHeaderWidget(),
        ),
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        color: AppColors.whiteColor,
        height: Get.height,
        padding: const EdgeInsets.only(
          left: AppDimens.spacingNormal,
          right: AppDimens.spacingNormal,
        ),
        width: Get.size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            Row(
              children: [
                _buildItemTopicWidget('Score', () {
                  Get.to(const SystemManagerDepartmentManagerPage(
                    isSystemManager: false,
                  ));
                }),
                // _buildItemTopicWidget('Đăng ký học', () {}),
                _buildItemTopicWidget('Exam schedule', () {
                  Get.to(const ExamSchedulePage());
                }),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                _buildItemTopicWidget('Department', () {
                  Get.to(const SystemManagerDepartmentManagerPage(
                    isSystemManager: false,
                  ));
                }),
                const Spacer(),
                // _buildItemTopicWidget('Học phí', () {}),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // Row(
            //   children: [
            //     _buildItemTopicWidget('Lộ trình', () {}),
            //     const Spacer(),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemTopicWidget(String title, Function() event) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: event,
        child: Card(
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppImages.imgDepartmentManager,
                width: Get.width / 2,
                fit: BoxFit.cover,
                height: 150,
              ),
              const SizedBox(
                height: AppDimens.spacingNormal,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.spacingNormal,
                ),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.color3C3A36S18W500,
                ),
              ),
              const SizedBox(
                height: AppDimens.spacingNormal,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderWidget() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: AppDimens.spacingNormal,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello,',
              style: AppTextStyle.color3C3A36S16,
            ),
            Text(
              '${authService.user.value?.displayName ?? ''},',
              style: AppTextStyle.color333333S32.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            teacherMainState.itemSelected.value = 2;
            teacherMainState.pageController.jumpToPage(2);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: ProgressiveImage.assetNetwork(
              placeholder: AppImages.imgLoading1,
              placeholderScale: 1.5,
              thumbnail: (authService.user.value != null &&
                      authService.user.value!.photoURL != null)
                  ? authService.user.value!.photoURL ??
                      'https://cdn.pixabay.com/photo/2022/05/08/20/21/flowers-7182930_1280.jpg'
                  : 'https://cdn.pixabay.com/photo/2022/05/08/20/21/flowers-7182930_1280.jpg',
              image: (authService.user.value != null &&
                      authService.user.value!.photoURL != null)
                  ? authService.user.value!.photoURL ??
                      'https://cdn.pixabay.com/photo/2022/05/08/20/21/flowers-7182930_1280.jpg'
                  : 'https://cdn.pixabay.com/photo/2022/05/08/20/21/flowers-7182930_1280.jpg',
              fit: BoxFit.cover,
              width: 48,
              height: 48,
            ),
          ),
        ),
        const SizedBox(
          width: AppDimens.spacingNormal,
        ),
      ],
    );
  }
}
