import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_images.dart';
import 'package:qldt/ui/system_manager/manager_user/manager_user_logic.dart';

import '../../../common/app_dimens.dart';
import '../../../common/app_text_style.dart';
import '../../widgets/button/back_button.dart';
import '../../widgets/textfields/app_text_field.dart';

class ManagerUserPage extends StatefulWidget {
  const ManagerUserPage({Key? key}) : super(key: key);

  @override
  State<ManagerUserPage> createState() => _ManagerUserPageState();
}

class _ManagerUserPageState extends State<ManagerUserPage> {
  final logic = Get.put(ManagerUserLogic());
  final state = Get.find<ManagerUserLogic>().state;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onRefresh() async {
    logic.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppbarWidget(),
            _buildSearchWidget(),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            Expanded(
              child: Obx(
                () => RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.separated(
                    itemBuilder: (c, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: AppDimens.spacingNormal,
                          vertical: AppDimens.spacingNormal,
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: (state.listPersonResponse[index].avatar !=
                                      null)
                                  ? Image.network(
                                      state.listPersonResponse[index].avatar ??
                                          '',
                                      width: 50,
                                      height: 50,
                                    )
                                  : Image.asset(
                                      AppImages.imgUser,
                                      width: 50,
                                      height: 50,
                                    ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('${state.listPersonResponse[index].name}',
                                style: AppTextStyle.color3C3A36S16W500),
                          ],
                        ),
                      );
                    },
                    itemCount: state.listPersonResponse.length,
                    separatorBuilder: (c, index) {
                      return const Divider(
                          height: 2, color: AppColors.grayColor);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
      child: AppTextField(
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
      ),
    );
  }

  Widget _buildAppbarWidget() {
    return Container(
      padding: const EdgeInsets.only(
          bottom: AppDimens.spacingNormal, top: AppDimens.spacingNormal),
      child: Row(
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
              "User manager",
              style: AppTextStyle.colorDarkS24W500,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: AppDimens.spacingNormal,
          ),
        ],
      ),
    );
  }
}
