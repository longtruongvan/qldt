import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:qldt/model/response/person_response.dart';
import 'package:qldt/services/auth_service.dart';
import 'package:qldt/ui/student/student_home/list_register/list_register_page.dart';
import 'package:qldt/ui/student/student_home/student_home_logic.dart';
import 'package:qldt/ui/student/student_main/student_main_logic.dart';
import 'package:qldt/ui/student/student_register_subject/student_register_subject_page.dart';
import 'package:qldt/ui/teacher/exam_schedule/list_exam/list_exam_page.dart';
import 'package:qldt/ui/teacher/teacher_score_manager/teacher_score_manager_page.dart';
import 'package:qldt/ui/teacher/teacher_score_manager/view_score/view_score_page.dart';
import 'package:qldt/ui/teacher/tuition/detail_tution/detail_tuition_page.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_dimens.dart';
import '../../../common/app_images.dart';
import '../../../common/app_text_style.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  final logic = Get.put(StudentHomeLogic());
  final state = Get.find<StudentHomeLogic>().state;
  final studentMainPageState = Get.find<StudentMainLogic>().state;
  final authService = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Container(
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
          _buildHeaderWidget(),
          const SizedBox(
            height: AppDimens.spacingNormal,
          ),
          Row(
            children: [
              _buildItemTopicWidget('Score', () {
                Get.to(const TeacherScoreManagerPage(
                  typeScoreManager: TypeScoreManager.student,
                ));
              }, AppImages.imgSpecialized1),
              _buildItemTopicWidget('Course', () {
                Get.to(const ListRegisterPage());
              }, AppImages.imgDepartmentManager),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              _buildItemTopicWidget('Exam schedule', () {
                Get.to(const ListExamPage());
              }, AppImages.imgSpecialized),
              _buildItemTopicWidget('Tuition', () {
                Get.to(DetailTuitionPage(
                  personResponse: [authService.person.value!],
                ));
              }, AppImages.imgCoruse),
            ],
          ),
          // const SizedBox(height: 10,),
          // Row(
          //   children: [
          //     _buildItemTopicWidget('Lộ trình', (){}),
          //     const Spacer(),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _buildItemTopicWidget(String title, Function() event, String image) {
    return Flexible(
      flex: 1,
      child: InkWell(
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
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello,',
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
            studentMainPageState.itemSelected.value = 3;
            studentMainPageState.pageController.jumpToPage(3);
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
        )
      ],
    );
  }
}
