import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:qldt/ui/teacher/teacher_home/teacher_home_logic.dart';

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
  final teacherHomeState = Get.find<TeacherHomeLogic>().state;

  @override
  void dispose() {
    Get.delete<TeacherHomeLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
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
                _buildItemTopicWidget('Điểm', (){}),
                _buildItemTopicWidget('Đăng ký học', (){}),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                _buildItemTopicWidget('Lịch thi', (){}),
                _buildItemTopicWidget('Học phí', (){}),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                _buildItemTopicWidget('Lộ trình', (){}),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemTopicWidget(String title,Function() event){
    return Flexible(
      flex: 1,
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
    );
  }

  Widget _buildHeaderWidget() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello,',
              style: AppTextStyle.color3C3A36S16,
            ),
            Text(
              'Juana Antonieta,',
              style: AppTextStyle.color333333S32.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            teacherHomeState.itemSelected.value = 2;
            teacherHomeState.pageController.jumpToPage(2);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: ProgressiveImage.assetNetwork(
              placeholder: AppImages.imgLoading1,
              placeholderScale: 1.5,
              thumbnail:
              'https://cdn.pixabay.com/photo/2022/05/08/20/21/flowers-7182930_1280.jpg',
              image:
              'https://cdn.pixabay.com/photo/2022/05/08/20/21/flowers-7182930_1280.jpg',
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
