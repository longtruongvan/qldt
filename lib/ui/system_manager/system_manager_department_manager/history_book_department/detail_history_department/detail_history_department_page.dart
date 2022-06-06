import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/model/response/department_history_response.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/history_book_department/detail_history_department/detail_history_department_logic.dart';

import '../../../../../common/app_dimens.dart';
import '../../../../../common/app_text_style.dart';
import '../../../../widgets/button/back_button.dart';

class DetailHistoryDepartmentPage extends StatefulWidget {
  final DepartmentHistoryResponse departmentHistoryResponse;

  const DetailHistoryDepartmentPage({
    Key? key,
    required this.departmentHistoryResponse,
  }) : super(key: key);

  @override
  State<DetailHistoryDepartmentPage> createState() =>
      _DetailHistoryDepartmentPageState();
}

class _DetailHistoryDepartmentPageState
    extends State<DetailHistoryDepartmentPage> {
  final logic = Get.put(DetailHistoryDepartmentLogic());
  final state = Get.find<DetailHistoryDepartmentLogic>().state;


  @override
  void initState() {
    logic.fetchData(widget.departmentHistoryResponse);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<DetailHistoryDepartmentLogic>();
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
            Container(
              padding: const EdgeInsets.all(AppDimens.spacingNormal),
              child: Obx(() => Table(
                columnWidths: const {
                  0: FlexColumnWidth(4.5),
                  1: FlexColumnWidth(5.5),
                },
                border: const TableBorder(
                  horizontalInside: BorderSide(
                    width: 1,
                    color: AppColors.grayColor,
                    style: BorderStyle.solid,
                  ),
                  verticalInside: BorderSide(
                    width: 1,
                    color: AppColors.grayColor,
                    style: BorderStyle.solid,
                  ),
                  top: BorderSide(
                    color: AppColors.grayColor,
                  ),
                  left: BorderSide(
                    color: AppColors.grayColor,
                  ),
                  right: BorderSide(
                    color: AppColors.grayColor,
                  ),
                  bottom: BorderSide(
                    color: AppColors.grayColor,
                  ),
                ),
                children: [
                  _buildRowTableWidget('Department name','${state.history.value.departmentResponse?.name}'),
                  _buildRowTableWidget('Time order:','${state.history.value.departmentHistoryResponse?.timeFormat}'),
                  _buildRowTableWidget('Order by','${state.history.value.personResponse?.name}'),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildRowTableWidget(String title,String value){
    return TableRow(children: [
      Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10,left: 10),
        child: Text(
          title,
          style: AppTextStyle.colorDarkS16W500,
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
        child: Text(
          value,
          style: AppTextStyle.colorDarkS16W500,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
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
          child: Text(
            '${widget.departmentHistoryResponse.title ?? widget.departmentHistoryResponse.id}',
            style: AppTextStyle.colorDarkS24W500,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          width: AppDimens.spacingNormal,
        ),
      ],
    );
  }
}
