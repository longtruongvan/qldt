import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/services/auth_service.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/system_manager_department_manager_page.dart';
import 'package:qldt/ui/teacher/exam_schedule/exam_schedule_page.dart';
import 'package:qldt/ui/teacher/student_register/student_register_page.dart';
import 'package:qldt/ui/teacher/teacher_home/teacher_home_logic.dart';
import 'package:qldt/ui/teacher/teacher_main/teacher_main_logic.dart';
import 'package:qldt/ui/teacher/teacher_score_manager/teacher_score_manager_page.dart';
import 'package:qldt/ui/teacher/teacher_score_manager/view_score/view_score_page.dart';
import 'package:qldt/ui/teacher/tuition/tuition_page.dart';

import '../../../common/app_dimens.dart';
import '../../../common/app_images.dart';
import '../../../common/app_text_style.dart';
import '../../../generated/l10n.dart';

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
    return Container(
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
              _buildItemTopicWidget(S.of(context).common_score, () {
                // Get.to(const ViewScorePage(students: []));
                Get.to(const TeacherScoreManagerPage(
                  typeScoreManager: TypeScoreManager.teacher,
                ));
              }, AppImages.imgSpecialized1),
              // _buildItemTopicWidget('Đăng ký học', () {}),
              _buildItemTopicWidget(S.of(context).common_exam_schedule, () {
                Get.to(const ExamSchedulePage());
              }, AppImages.imgDepartmentManager),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              _buildItemTopicWidget(S.of(context).departmentManager, () {
                Get.to(const SystemManagerDepartmentManagerPage(
                  isSystemManager: false,
                ));
              }, AppImages.imgSpecialized),
              _buildItemTopicWidget(S.of(context).tuition, () {
                Get.to(const TuitionPage());
              }, AppImages.imgCoruse),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            S.of(context).home_student_register.toUpperCase(),
            style: AppTextStyle.color3C3A36S20W500.copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: (){
              Get.to(const StudentRegisterList());
            },
            child: SizedBox(
              width: Get.width,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 1,
                child: Container(
                  padding: const EdgeInsets.all(AppDimens.spacingNormal),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Icon(
                          Icons.send,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: Text(
                        S.of(context).common_send_to_me,
                        style: AppTextStyle.color3C3A36S18W500,
                      )),
                      const Icon(Icons.navigate_next_sharp)
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItemTopicWidget(String title, Function() event, String image) {
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
                image,
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
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).common_hello,
                style: AppTextStyle.color3C3A36S16,
              ),
              Text(
                '${authService.person.value?.name ?? ''},',
                style: AppTextStyle.color333333S32.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
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
              thumbnail: (authService.person.value != null &&
                      authService.person.value!.avatar != null)
                  ? authService.person.value!.avatar ??
                      'https://cdn.pixabay.com/photo/2022/05/08/20/21/flowers-7182930_1280.jpg'
                  : 'https://cdn.pixabay.com/photo/2022/05/08/20/21/flowers-7182930_1280.jpg',
              image: (authService.person.value != null &&
                      authService.person.value!.avatar != null)
                  ? authService.person.value!.avatar ??
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
