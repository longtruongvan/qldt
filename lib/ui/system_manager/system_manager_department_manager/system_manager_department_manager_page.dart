import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_dimens.dart';
import 'package:qldt/common/app_images.dart';
import 'package:qldt/common/app_text_style.dart';
import 'package:qldt/model/response/building_response.dart';
import 'package:qldt/model/response/department_response.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/add_department/add_department_page.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/detail_department/detail_department_page.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/system_manager_department_logic.dart';
import 'package:qldt/ui/widgets/button/back_button.dart';

class SystemManagerDepartmentManagerPage extends StatefulWidget {
  const SystemManagerDepartmentManagerPage({Key? key}) : super(key: key);

  @override
  State<SystemManagerDepartmentManagerPage> createState() =>
      _SystemManagerDepartmentManagerState();
}

class _SystemManagerDepartmentManagerState
    extends State<SystemManagerDepartmentManagerPage> {
  final logic = Get.put(SystemManagerDepartmentLogic());
  final state = Get.find<SystemManagerDepartmentLogic>().state;

  @override
  void dispose() {
    Get.delete<SystemManagerDepartmentLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.spacingNormal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppbarWidget(),
              const SizedBox(height: AppDimens.spacingNormal),
              _buildSearchWidget(),
              const SizedBox(height: AppDimens.spacingNormal * 2),
              _buildTitleListWidget(),
              const SizedBox(height: AppDimens.spacingNormal),
              _buildListDepartmentWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListDepartmentWidget() {
    return Expanded(
      child: Obx(
        () => DefaultTabController(
          length: state.listData.length,
          child: Column(
            children: [
              _buildTabTitleBuildingWidget(),
              _buildListDepartmentInBuildingWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListDepartmentInBuildingWidget() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: AppDimens.spacingNormal),
        child: TabBarView(
          children: state.listBuilding.map((buildingResponse) {
            return Container(
              child: ListView.builder(
                itemBuilder: (c, index) {
                  return _buildItemDepartmentWidget(
                    buildingResponse,
                    state.listData[buildingResponse]![index],
                    index,
                  );
                },
                shrinkWrap: true,
                itemCount: (state.listData[buildingResponse] ?? []).length,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildItemDepartmentWidget(BuildingResponse buildingResponse,
      DepartmentResponse departmentResponse, int index) {
    return GestureDetector(
      onTap: () {
        Get.to(
          DetailDepartmentPage(
            departmentResponse: departmentResponse,
            buildingResponse: buildingResponse,
            listBuildingResponse: state.listBuilding,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(AppDimens.spacingNormal),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: (departmentResponse.status ?? false)
                  ? Colors.green
                  : AppColors.grayColor,
              width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.icClassroom,
              width: 24,
              height: 24,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                "P: ${state.listData[buildingResponse]![index].name}",
                style: (departmentResponse.status ?? false)
                    ? AppTextStyle.colorDarkS16W500
                    : AppTextStyle.colorGrayS16W500,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (departmentResponse.status ?? false)
                    ? Colors.green
                    : AppColors.grayColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Status: ${(departmentResponse.status ?? false) ? "Online" : "Offline"}",
                style: AppTextStyle.colorWhiteS14W500,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTabTitleBuildingWidget() {
    return TabBar(
      indicatorColor: Colors.transparent,
      isScrollable: true,
      tabs: state.listBuilding.map((buildingResponse) {
        return Container(
          child: Text(buildingResponse.name ?? ''),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
        );
      }).toList(),
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        // Creates border
        color: AppColors.primaryColor,
      ),
      labelColor: AppColors.whiteColor,
      unselectedLabelColor: AppColors.grayColor,
      unselectedLabelStyle:
          const TextStyle(color: AppColors.grayColor, fontSize: 16),
      labelStyle: const TextStyle(color: AppColors.primaryColor, fontSize: 16),
    );
  }

  Widget _buildTitleListWidget() {
    return Row(
      children: [
        Text(
          "List of departments",
          style: AppTextStyle.colorDarkS20W500,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Get.to(const AddDepartmentPage());
          },
          child: const Icon(
            Icons.add_circle,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchWidget() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: AppColors.grayColor,
            width: 1,
          )),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            size: 24,
            color: AppColors.grayColor,
          ),
          const SizedBox(width: 5),
          Text(
            "Search",
            style: AppTextStyle.colorGrayS14W500,
          )
        ],
      ),
    );
  }

  Widget _buildAppbarWidget() {
    return Row(
      children: [
        AppBackButton(eventHandler: () {
          Get.back(closeOverlays: true);
        }),
        const SizedBox(width: AppDimens.spacingNormal),
        Text("Department manager", style: AppTextStyle.colorDarkS24W500),
      ],
    );
  }
}
