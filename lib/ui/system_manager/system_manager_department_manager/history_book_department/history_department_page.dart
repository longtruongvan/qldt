import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/history_book_department/detail_history_department/detail_history_department_page.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/history_book_department/history_department_logic.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/history_book_department/history_department_state.dart';

import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../widgets/button/back_button.dart';

class HistoryDepartmentPage extends StatefulWidget {
  const HistoryDepartmentPage({Key? key}) : super(key: key);

  @override
  State<HistoryDepartmentPage> createState() => _HistoryDepartmentPageState();
}

class _HistoryDepartmentPageState extends State<HistoryDepartmentPage> {
  final logic = Get.put(HistoryDepartmentLogic());
  final state = Get.find<HistoryDepartmentLogic>().state;

  @override
  void dispose() {
    Get.delete<HistoryDepartmentLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            _buildAppbarWidget(),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
            const Card(
              child: Divider(
                height: 0.5,
                color: AppColors.grayColor,
              ),
            ),
            _buildListHistoryWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildListHistoryWidget() {
    return Expanded(
      child: Obx(() => ListView.builder(
            shrinkWrap: true,
            itemBuilder: (c, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(DetailHistoryDepartmentPage(
                    departmentHistoryResponse: state.listHistory[index],
                  ));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppDimens.spacingNormal,
                    vertical: 10,
                  ),
                  child: Card(
                    elevation: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.spacingNormal,
                          vertical: AppDimens.spacingNormal),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              state.listHistory[index].avatarUrl ?? '',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  state.listHistory[index].title ??
                                      state.listHistory[index].idOrder ??
                                      '',
                                  style: AppTextStyle.colorDarkS16W500.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  state.listHistory[index].timeFormat ?? '',
                                  style: AppTextStyle.colorDarkS16W500.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: state.listHistory.length,
          )),
    );
  }

  Widget _buildAppbarWidget() {
    return Row(
      children: [
        const SizedBox(
          width: AppDimens.spacingNormal,
        ),
        AppBackButton(eventHandler: () {
          Get.back(closeOverlays: true);
        }),
        const SizedBox(width: AppDimens.spacingNormal),
        Expanded(
          child: Text("History", style: AppTextStyle.colorDarkS24W500),
        ),
        const SizedBox(
          width: AppDimens.spacingNormal,
        ),
      ],
    );
  }
}
