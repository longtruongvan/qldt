import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_dimens.dart';
import 'package:qldt/ui/widgets/textfields/app_text_field.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';
import '../../../../common/app_text_style.dart';
import '../../../../model/response/building_response.dart';
import '../../../../model/response/department_response.dart';
import '../../../widgets/button/back_button.dart';
import '../detail_department/detail_department_page.dart';
import 'search_department_logic.dart';

class SearchDepartmentPage extends StatefulWidget {
  const SearchDepartmentPage({Key? key}) : super(key: key);

  @override
  State<SearchDepartmentPage> createState() => _SearchDepartmentPageState();
}

class _SearchDepartmentPageState extends State<SearchDepartmentPage> {
  final logic = Get.put(SearchDepartmentLogic());
  final state = Get.find<SearchDepartmentLogic>().state;

  Future<void> _refresh() async{
    logic.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
          const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
          child: Stack(
            children: [
              Column(
                children: [
                  _buildAppbarWidget(),
                  const SizedBox(height: AppDimens.spacingNormal),
                  _buildSearchWidget(),
                  const SizedBox(height: AppDimens.spacingNormal),
                  _buildBodyWidget(),
                ],
              ),
              _buildLoadingWidget()
            ],
          ),
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
            callback: (){
              // logic.fetchData();
            },
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
                "P: ${departmentResponse.name}",
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

  Widget _buildBodyWidget() {
    return Obx(
      () => Expanded(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.builder(
            itemBuilder: (c, index) {
              return _buildItemDepartmentWidget(
                state.listBuilding[index],
                state.listDepartment[index],
                index,
              );
            },
            itemCount: state.listDepartment.length,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Obx(() => Center(
          child: Visibility(
            visible: state.stateLoading.value,
            child: const CircularProgressIndicator(),
          ),
        ));
  }

  Widget _buildSearchWidget() {
    return AppTextField(
      controller: state.searchTextController,
      hintText: 'Search',
      hintStyle: AppTextStyle.colorGrayS14W500,
      suffixIcon: const Icon(
        Icons.search,
        size: 24,
        color: AppColors.grayColor,
      ),
      onChanged: (value) {
        logic.searchHandler(value);
      },
    );
  }

  Widget _buildAppbarWidget() {
    return Row(
      children: [
        AppBackButton(eventHandler: () {
          Get.back(closeOverlays: true);
        }),
        const SizedBox(width: AppDimens.spacingNormal),
        Expanded(
          child:
              Text('Search department', style: AppTextStyle.colorDarkS24W500),
        ),
      ],
    );
  }

  @override
  void dispose() {
    Get.delete<SearchDepartmentLogic>();
    super.dispose();
  }
}
