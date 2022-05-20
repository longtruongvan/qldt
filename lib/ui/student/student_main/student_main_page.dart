import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/services/fcm_service.dart';
import 'package:qldt/ui/student/student_home/student_home_page.dart';
import 'package:qldt/ui/student/student_main/student_main_logic.dart';
import 'package:qldt/ui/student/student_notification/student_notification_page.dart';
import 'package:qldt/ui/student/student_profile/student_profile_page.dart';
import 'package:qldt/ui/teacher/teacher_notification/teacher_notification_page.dart';
import 'package:qldt/ui/teacher/teacher_profile/teacher_profile_page.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_text_style.dart';

class StudentMainPage extends StatefulWidget {
  const StudentMainPage({Key? key}) : super(key: key);

  @override
  State<StudentMainPage> createState() => _StudentMainPageState();
}

class _StudentMainPageState extends State<StudentMainPage> with AutomaticKeepAliveClientMixin{
  final logic = Get.put(StudentMainLogic());
  final state = Get.find<StudentMainLogic>().state;

  final List<Widget> _pages = [
    const StudentHomePage(),
    const TeacherNotificationPage(),
    const TeacherProfilePage(),
  ];

  void _onTapItem(int itemSelected) {
    state.itemSelected.value = itemSelected;
    logic.switchTab();
  }


  @override
  void initState() {
    FcmService.getToken();
    FcmService.handlerMessageInForeground();
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<StudentMainLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBodyWidget(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBodyWidget() {
    return PageView(
      children: _pages,
      controller: state.pageController,
      onPageChanged: (position){
        _onTapItem(position);
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grayColor),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Obx(
            () => Row(
          children: [
            _buildBottomNavItem(
              title: "Home",
              icon: Icons.home_filled,
              positionItem: 0,
            ),
            _buildBottomNavItem(
              title: "Alert",
              icon: Icons.notifications_rounded,
              positionItem: 1,
            ),
            _buildBottomNavItem(
              title: "Profile",
              icon: Icons.person,
              positionItem: 2,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required String title,
    required IconData icon,
    required int positionItem,
  }) {
    return InkWell(
      onTap: () {
        _onTapItem(positionItem);
      },
      child: Container(
        height: 90,
        width: (Get.width/3)-2,
        decoration: const BoxDecoration(
            color: Colors.transparent
        ),
        child: Column(
          children: [
            const SizedBox(height: 18,),
            Icon(icon,
                size: 24,
                color: (state.itemSelected.value == positionItem)
                    ? AppColors.primaryColor
                    : AppColors.grayColor),
            Text(
              title,
              style: (state.itemSelected.value == positionItem)
                  ? AppTextStyle.colorPrimaryS14
                  : AppTextStyle.colorGrayS14,
            ),
            const SizedBox(height: 18,),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
