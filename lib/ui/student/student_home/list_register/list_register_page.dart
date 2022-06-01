import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_images.dart';
import 'package:qldt/ui/student/student_home/list_register/list_register_logic.dart';

import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../widgets/button/back_button.dart';

class ListRegisterPage extends StatefulWidget {
  const ListRegisterPage({Key? key}) : super(key: key);

  @override
  State<ListRegisterPage> createState() => _ListRegisterPageState();
}

class _ListRegisterPageState extends State<ListRegisterPage> {
  final logic = Get.put(ListRegisterLogic());
  final state = Get.find<ListRegisterLogic>().state;

  @override
  void dispose() {
    Get.delete<ListRegisterLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        elevation: 1,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: _buildAppbarWidget(),
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
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

  Future<void> _refresh() async {
    // logic.fetchData();
  }

  Widget _buildBodyWidget() {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Obx(() => ListView.builder(
            padding: const EdgeInsets.only(top: AppDimens.spacingNormal),
            itemBuilder: (c, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primaryColor,
                ),
                width: Get.width - 72,
                child: Container(
                  padding: const EdgeInsets.only(
                    left: AppDimens.spacingNormal,
                    top: AppDimens.spacingNormal,
                    bottom: AppDimens.spacingNormal,
                    right: AppDimens.spacingNormal,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Table(
                        columnWidths: const {
                          0:FlexColumnWidth(2.2),
                          1:FlexColumnWidth(3),
                        },
                        children: [
                          TableRow(children: [
                            Text(
                              'Name course: ',
                              style: AppTextStyle.colorWhiteS16W500,
                            ),
                            Text(
                              '${state.listCourse[index].subjectResponse?.name}',
                              style: AppTextStyle.colorDarkS14Bold,
                            ),
                          ]),
                          TableRow(children: [
                            Text(
                              'Specialized',
                              style: AppTextStyle.colorWhiteS16W500,
                            ),
                            Text(
                              '${state.listCourse[index].specializedResponse?.name}',
                              style: AppTextStyle.colorDarkS14Bold,
                            ),
                          ]),
                          TableRow(children: [
                            Text(
                              'Time payment:',
                              style: AppTextStyle.colorWhiteS16W500,
                            ),
                            Text(
                              '${state.listCourse[index].subjectRegisterRequest?.timePayment}',
                              style: AppTextStyle.colorDarkS14Bold,
                            ),
                          ]),
                          TableRow(children: [
                            Text(
                              'Status:',
                              style: AppTextStyle.colorWhiteS16W500,
                            ),
                            Text(
                              '${state.listCourse[index].subjectRegisterRequest?.isAccept}',
                              style: AppTextStyle.colorDarkS14Bold,
                            ),
                          ])
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: state.listCourse.length,
          )),
    );
  }

  Widget _buildLoadingWidget() {
    return Obx(
      () => Visibility(
        visible: state.stateLoading.value,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
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
          Text(
            "Courses",
            style: AppTextStyle.colorDarkS24W500,
          ),
          const SizedBox(
            width: AppDimens.spacingNormal,
          ),
        ],
      ),
    );
  }
}
