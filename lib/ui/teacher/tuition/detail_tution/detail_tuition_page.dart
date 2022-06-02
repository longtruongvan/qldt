import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_snack_bar.dart';
import 'package:qldt/model/response/person_response.dart';
import 'package:qldt/services/auth_service.dart';
import 'package:qldt/ui/teacher/tuition/detail_tution/detail_tuition_logic.dart';

import '../../../../common/app_dimens.dart';
import '../../../../common/app_images.dart';
import '../../../../common/app_text_style.dart';
import '../../../widgets/button/back_button.dart';

class DetailTuitionPage extends StatefulWidget {
  final PersonResponse personResponse;

  const DetailTuitionPage({
    Key? key,
    required this.personResponse,
  }) : super(key: key);

  @override
  State<DetailTuitionPage> createState() => _DetailTuitionPageState();
}

class _DetailTuitionPageState extends State<DetailTuitionPage> {
  final logic = Get.put(DetailTuitionLogic());
  final state = Get.find<DetailTuitionLogic>().state;
  final auth = Get.find<AuthService>();

  @override
  void initState() {
    logic.fetchData(widget.personResponse);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<DetailTuitionLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppbarWidget(),
                const SizedBox(
                  height: AppDimens.spacingNormal,
                ),
                Expanded(child: _buildBodyWidget()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    logic.fetchData(widget.personResponse);
  }

  Widget _buildBodyWidget() {
    return Obx(() {
      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemBuilder: (c, index) {
            return _buildItemTuitionWidget(index);
          },
          itemCount: state.listTuition.length,
        ),
      );
    });
  }

  TableRow _buildTableRowWidget(String title, String value) {
    return TableRow(children: [
      Container(
        margin: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
        child: Text(
          title,
          style: AppTextStyle.color3C3A36S16W500
              .copyWith(color: AppColors.primaryColor),
        ),
      ),
      Container(
          margin: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
          child: Text(
            value,
            style: AppTextStyle.color3C3A36S16W500.copyWith(
              color: AppColors.primaryColor,
            ),
          )),
    ]);
  }

  Widget _buildActionInfoStudentWidget(
    int index,
    String idStudent,
  ) {
    if (auth.person.value?.id != idStudent) {
      return Container();
    }
    return InkWell(
      onTap: () {
        Get.dialog(AlertDialog(
          title: Text(
            'Notification',
            style: AppTextStyle.color3C3A36S16W500,
          ),
          content: Text(
            'Do you want to pay tuition fees for this semester?. Please confirm',
            style: AppTextStyle.color3C3A36S16,
          ),
          actions: [
            FlatButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Cancel',
                  style: AppTextStyle.colorPrimaryS16,
                )),
            FlatButton(
                onPressed: () {
                  Get.back();
                  logic.payment(index);
                },
                child: Text(
                  'OK',
                  style: AppTextStyle.colorPrimaryS16,
                ))
          ],
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: !(state.listTuition[index].state ?? false)
              ? AppColors.primaryColor
              : AppColors.successColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
                !(state.listTuition[index].state ?? false)
                    ? Icons.payment
                    : Icons.check,
                size: 16,
                color: AppColors.whiteColor),
            const SizedBox(width: 5),
            Text('Payment', style: AppTextStyle.colorWhiteS16W500),
          ],
        ),
      ),
    );
  }

  Widget _buildItemTuitionWidget(int index) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.spacingNormal),
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: Image.asset(
              AppImages.icSubjectSelected,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: AppDimens.spacingNormal),
          Expanded(
            child: ExpansionTile(
              children: [
                Table(
                    border: const TableBorder(
                      horizontalInside: BorderSide(
                        width: 0.5,
                        color: AppColors.grayColor,
                        style: BorderStyle.solid,
                      ),
                      verticalInside: BorderSide(
                        width: 0.5,
                        color: AppColors.grayColor,
                        style: BorderStyle.solid,
                      ),
                    ),
                    columnWidths: const {
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(7),
                    },
                    children: [
                      _buildTableRowWidget(
                        'Tuition:',
                        '${state.listTuition[index].price} (VND)',
                      ),
                      _buildTableRowWidget(
                        'Status:',
                        (state.listTuition[index].state ?? false)
                            ? 'Đã thanh toán'
                            : 'Chưa thanh toán',
                      ),
                      _buildTableRowWidget(
                        'Method:',
                        (state.listTuition[index].state ?? false)
                            ? 'Master card'
                            : 'Unknown',
                      ),
                    ]),
                const SizedBox(height: AppDimens.spacingNormal),
                _buildActionInfoStudentWidget(
                  index,
                  state.listTuition[index].idStudent ?? '',
                ),
                const SizedBox(height: AppDimens.spacingNormal),
              ],
              title: Text(
                state.listTuition[index].schoolYear ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.color3C3A36S16W500,
              ),
            ),
          ),
        ],
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
            "Detail tuition",
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
