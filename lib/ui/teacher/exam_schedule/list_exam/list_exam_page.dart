import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/ui/teacher/exam_schedule/list_exam/list_exam_logic.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/button/back_button.dart';
import '../detail_exam_schedule/detail_exam_schedule_page.dart';

class ListExamPage extends StatefulWidget {
  const ListExamPage({Key? key}) : super(key: key);

  @override
  State<ListExamPage> createState() => _ListExamPageState();
}

class _ListExamPageState extends State<ListExamPage> {
  final logic = Get.put(ListExamLogic());
  final state = Get.find<ListExamLogic>().state;

  @override
  void dispose() {
    Get.delete<ListExamLogic>();
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
          preferredSize: const Size.fromHeight(0),
          child: _buildAppbarWidget(),
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      body: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.spacingNormal,
            vertical: AppDimens.spacingNormal),
        color: AppColors.whiteColor,
        child: SafeArea(
          child: Obx(() => RefreshIndicator(
                child: ListView.builder(
                  itemBuilder: (c, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(DetailExamSchedulePage(
                          exampleScheduleResponse:
                              state.listExamSchedule[index],
                        ));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.grayColor,
                              width: 1,
                            )),
                        padding: const EdgeInsets.all(AppDimens.spacingNormal),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${state.listExamSchedule[index].title}',
                                  style: AppTextStyle.color3C3A36S16
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${state.listExamSchedule[index].timeStart} - ${state.listExamSchedule[index].timeEnd}',
                                  style: AppTextStyle.colorGrayS16W500,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${state.listExamSchedule[index].dayStart}',
                                  style: AppTextStyle.colorGrayS16W500,
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.navigate_next_sharp,
                              color: AppColors.grayColor,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: state.listExamSchedule.length,
                ),
                onRefresh: _onRefresh,
              )),
        ),
      ),
    );
  }

  Future _onRefresh() async {
    logic.fetchData();
  }

  Widget _buildAppbarWidget() {
    return Row(
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
            S.of(context).examSchedules,
            style: AppTextStyle.colorDarkS24W500,
          ),
        ),
        const SizedBox(
          width: AppDimens.spacingNormal,
        ),
      ],
    );
  }
}
