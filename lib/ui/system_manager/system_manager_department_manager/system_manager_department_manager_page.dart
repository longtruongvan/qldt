import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_dimens.dart';
import 'package:qldt/common/app_text_style.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/add_department/add_department_page.dart';
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
              Container(
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
              ),
              const SizedBox(height: AppDimens.spacingNormal * 2),
              Row(
                children: [
                  Text(
                    "List of departments",
                    style: AppTextStyle.colorDartS20W500,
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
              ),
              const SizedBox(height: AppDimens.spacingNormal),
              Expanded(
                child: Obx(
                  () => DefaultTabController(
                    length: state.listBuilding.length,
                    child: Column(
                      children: [
                        TabBar(
                          indicatorColor: Colors.transparent,
                          isScrollable: true,
                          tabs: state.listBuilding.map((buildingResponse) {
                            return Container(
                              child: Text(buildingResponse.name??''),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                            );
                          }).toList(),
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            // Creates border
                            color: AppColors.primaryColor,
                          ),
                          labelColor: AppColors.whiteColor,
                          unselectedLabelColor: AppColors.grayColor,
                          unselectedLabelStyle: const TextStyle(
                              color: AppColors.grayColor, fontSize: 16),
                          labelStyle: const TextStyle(
                              color: AppColors.primaryColor, fontSize: 16),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: AppDimens.spacingNormal),
                            child: TabBarView(
                              children: state.listBuilding.map((buildingResponse){
                                return Container(
                                  color: Colors.red,
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppbarWidget() {
    return Row(
      children: [
        AppBackButton(eventHandler: () {
          Get.back();
        }),
        const SizedBox(width: AppDimens.spacingNormal),
        Text("Department manager", style: AppTextStyle.colorDarkS24W500),
      ],
    );
  }
}
