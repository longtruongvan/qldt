import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_dimens.dart';
import 'package:qldt/common/app_images.dart';
import 'package:qldt/common/app_text_style.dart';
import 'package:qldt/services/auth_service.dart';
import 'package:qldt/ui/system_manager/main/system_manager_main_logic.dart';
import 'package:qldt/ui/system_manager/manager_user/manager_user_page.dart';
import 'package:qldt/ui/system_manager/specialized/specialized_page.dart';
import 'package:qldt/ui/system_manager/subjects/subject_page.dart';

import '../../../generated/l10n.dart';
import 'system_manager_home_logic.dart';

class SystemManagerHomePage extends StatefulWidget {
  const SystemManagerHomePage({Key? key}) : super(key: key);

  @override
  State<SystemManagerHomePage> createState() => _SystemManagerHomePageState();
}

class _SystemManagerHomePageState extends State<SystemManagerHomePage>
    with AutomaticKeepAliveClientMixin {
  final logic = Get.put(SystemManagerHomeLogic());
  final systemManagerMainPageState = Get.find<SystemManagerMainLogic>().state;
  final authService = Get.find<AuthService>();

  @override
  bool get wantKeepAlive => true;

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
      padding: const EdgeInsets.only(
        left: AppDimens.spacingNormal,
        right: AppDimens.spacingNormal,
      ),
      width: Get.size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            _buildItemDepartmentManager(),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            _buildItemManagerUser(),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            _buildItemSpecialized(),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            _buildItemSubjectManager(),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemSubjectManager() {
    return GestureDetector(
      onTap: () {
        Get.to(const SubjectPage());
      },
      child: Container(
        width: Get.width - 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.grayColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.imgSubjectManager,
              width: Get.width,
              fit: BoxFit.cover,
              height: 194,
            ),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spacingNormal,
              ),
              child: Text(
                S.of(context).subjectManager,
                style: AppTextStyle.color3C3A36S24W500,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spacingNormal,
              ),
              child: Text(
                S.of(context).addEditDeleteSearchSetSubject,
                style: AppTextStyle.color3C3A36S14W400,
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

  Widget _buildItemSpecialized() {
    return GestureDetector(
      onTap: () {
        Get.to(const SpecializedPage());
      },
      child: Container(
        width: Get.width - 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.grayColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.imgSpecialized,
              width: Get.width,
              fit: BoxFit.cover,
              height: 194,
            ),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spacingNormal,
              ),
              child: Text(
                S.of(context).system_mn_specializedManager,
                style: AppTextStyle.color3C3A36S24W500,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spacingNormal,
              ),
              child: Text(
                S.of(context).addEditDeleteSearchSetSpecialized,
                style: AppTextStyle.color3C3A36S14W400,
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
        const SizedBox(
          width: AppDimens.spacingNormal,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${S.of(context).common_hello},',
                style: AppTextStyle.color3C3A36S16,
              ),
              Text(
                authService.person.value?.name ?? '',
                style: AppTextStyle.color333333S32.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                width: AppDimens.spacingNormal,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () {
            systemManagerMainPageState.itemSelected.value = 2;
            systemManagerMainPageState.pageController.jumpToPage(2);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: ProgressiveImage.assetNetwork(
              placeholder: AppImages.imgLoading1,
              placeholderScale: 1.5,
              thumbnail:
              (authService.person.value != null &&
                  authService.person.value!.avatar != null)
                  ? authService.person.value!.avatar??'https://cdn.pixabay.com/photo/2022/05/08/20/21/flowers-7182930_1280.jpg'
                  : 'https://cdn.pixabay.com/photo/2022/05/08/20/21/flowers-7182930_1280.jpg',
              image: (authService.person.value != null &&
                      authService.person.value!.avatar != null)
                  ? authService.person.value!.avatar??'https://cdn.pixabay.com/photo/2022/05/08/20/21/flowers-7182930_1280.jpg'
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

  Widget _buildItemDepartmentManager() {
    return GestureDetector(
      onTap: () {
        logic.goToDepartmentManager();
      },
      child: Container(
        width: Get.width - 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.grayColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.imgDepartmentManager,
              width: Get.width,
              fit: BoxFit.cover,
              height: 194,
            ),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spacingNormal,
              ),
              child: Text(
                S.of(context).departmentManager,
                style: AppTextStyle.color3C3A36S24W500,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spacingNormal,
              ),
              child: Text(
                S.of(context).addEditDeleteSearchSetDepartments,
                style: AppTextStyle.color3C3A36S14W400,
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

  Widget _buildItemManagerUser() {
    return GestureDetector(
      onTap: (){
        Get.to(const ManagerUserPage());
      },
      child: Container(
        width: Get.width - 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.grayColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.imgManagerUserItem,
              fit: BoxFit.cover,
              height: 194,
              width: Get.width,
            ),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spacingNormal,
              ),
              child: Text(
                S.of(context).userManager,
                style: AppTextStyle.color3C3A36S24W500,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spacingNormal,
              ),
              child: Text(
                S.of(context).youCanAddOrLevelPermissionsForUser,
                style: AppTextStyle.color3C3A36S14W400,
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
}
