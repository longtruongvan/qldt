import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/ui/splash/splash_logic.dart';
import 'package:qldt/ui/teacher/teacher_home/teacher_home_page.dart';
import 'package:qldt/ui/teacher/teacher_main/teacher_main_logic.dart';
import 'package:qldt/ui/teacher/teacher_profile/teacher_profile_page.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_text_style.dart';
import '../../../services/fcm_service.dart';
import '../../setting/setting_page.dart';
import '../teacher_notification/teacher_notification_page.dart';

class TeacherMainPage extends StatefulWidget {
  const TeacherMainPage({Key? key}) : super(key: key);

  @override
  State<TeacherMainPage> createState() => _TeacherMainPageState();
}

class _TeacherMainPageState extends State<TeacherMainPage> with AutomaticKeepAliveClientMixin{
  final logic = Get.put(TeacherMainLogic());
  final state = Get.find<TeacherMainLogic>().state;

  final List<Widget> _pages = [
    const TeacherHomePage(),
    const TeacherNotificationPage(personType: PersonType.GV),
    const TeacherProfilePage(),
    const SettingPage(),
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
    Get.delete<TeacherMainLogic>();
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
            ),
            _buildBottomNavItem(
              title: "Setting",
              icon: Icons.settings,
              positionItem: 3,
            ),
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
        width: (Get.width/4)-2,
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
