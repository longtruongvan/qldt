import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_dimens.dart';
import 'package:qldt/common/app_images.dart';
import 'package:qldt/common/app_text_style.dart';
import 'package:qldt/ui/system_manager/main/system_manager_main_logic.dart';

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

  @override
  bool get wantKeepAlive => true;

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
      child: Container(
        padding: const EdgeInsets.only(
          left: AppDimens.spacingNormal,
          right: AppDimens.spacingNormal,
        ),
        width: Get.size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderWidget(),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            _buildItemDepartmentManager(),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            _buildItemManagerUser(),
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
            systemManagerMainPageState.itemSelected.value = 2;
            systemManagerMainPageState.pageController.jumpToPage(2);
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
                "Department Manager",
                style: AppTextStyle.color3C3A36S24W500,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spacingNormal,
              ),
              child: Text(
                "Add, edit, delete, search, set departments, ...",
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
    return Container(
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
          ),
          const SizedBox(
            height: AppDimens.spacingNormal,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.spacingNormal,
            ),
            child: Text(
              "User Manager",
              style: AppTextStyle.color3C3A36S24W500,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.spacingNormal,
            ),
            child: Text(
              "You can add or level permissions for user, ...",
              style: AppTextStyle.color3C3A36S14W400,
            ),
          ),
          const SizedBox(
            height: AppDimens.spacingNormal,
          ),
        ],
      ),
    );
  }
}
