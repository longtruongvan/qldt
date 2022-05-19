import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_dimens.dart';
import 'package:qldt/common/app_images.dart';
import 'package:qldt/common/app_text_style.dart';
import 'package:qldt/ui/system_manager/specialized/detail_specialized/detail_specialized_page.dart';
import 'package:qldt/ui/system_manager/specialized/specialized_logic.dart';

import '../../widgets/button/back_button.dart';
import '../../widgets/textfields/app_text_field.dart';
import 'add_specialized/add_specialized_page.dart';

class SpecializedPage extends StatefulWidget {
  const SpecializedPage({Key? key}) : super(key: key);

  @override
  State<SpecializedPage> createState() => _SpecializedPageState();
}

class _SpecializedPageState extends State<SpecializedPage> {
  final logic = Get.put(SpecializedLogic());
  final state = Get.find<SpecializedLogic>().state;

  @override
  void dispose() {
    Get.delete<SpecializedLogic>();
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
          child: _buildAppbarWidget(),
          preferredSize: const Size.fromHeight(10),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: AppColors.whiteColor,
          padding: const EdgeInsets.all(AppDimens.spacingNormal),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildBodyWidget(),
              _buildLoadingWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Obx(
      () => Center(
        child: Visibility(
          visible: state.stateLoading.value,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future _refeshListener() async {
    logic.fetchData();
  }

  Widget _buildBodyWidget() {
    return Column(
      children: [
        _buildSearchWidget(),
        Expanded(
          child: Obx(
            () => RefreshIndicator(
              onRefresh: _refeshListener,
              child: ListView.separated(
                itemBuilder: (c, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(DetailSpecializedPage(
                        specializedResponse: state.listSpecialized[index],
                      ));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Image.asset(
                              state.listSpecialized[index].icon ??
                                  AppImages.icSpecialized1,
                              width: 24,
                              height: 24),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "${state.listSpecialized[index].displayName} (${state.listSpecialized[index].name})",
                              style: AppTextStyle.colorDarkS16W500,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.navigate_next_sharp,
                            color: AppColors.darkColor,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(AppDimens.spacingNormal),
                    ),
                  );
                },
                separatorBuilder: (c, index) {
                  return const Divider(
                    color: AppColors.grayColor,
                    height: 1,
                  );
                },
                itemCount: state.listSpecialized.length,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildAppbarWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const SizedBox(
              width: AppDimens.spacingNormal,
            ),
            AppBackButton(eventHandler: () {
              Get.back();
            }),
            const SizedBox(width: AppDimens.spacingNormal),
            Expanded(
              child: Text(
                "Specialized",
                style: AppTextStyle.colorDarkS24W500,
              ),
            ),
            DropdownButton<String>(
              items: <String>['Add'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: AppTextStyle.colorDarkS16W500,
                  ),
                );
              }).toList(),
              onChanged: (_) {
                if (_ == 'Add') {
                  Get.to(const AddSpecializedPage());
                }
              },
              icon: const Icon(Icons.more_vert),
              underline: Container(),
            ),
            const SizedBox(
              width: AppDimens.spacingNormal,
            ),
          ],
        ),
      ],
    );
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
}
