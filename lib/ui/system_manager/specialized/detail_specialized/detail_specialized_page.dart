import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_images.dart';
import 'package:qldt/model/response/specialized_response.dart';
import 'package:qldt/ui/system_manager/specialized/update_specialized/update_specialized_page.dart';

import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../widgets/button/back_button.dart';
import 'detail_specialized_logic.dart';

class DetailSpecializedPage extends StatefulWidget {
  final SpecializedResponse specializedResponse;

  const DetailSpecializedPage({
    Key? key,
    required this.specializedResponse,
  }) : super(key: key);

  @override
  State<DetailSpecializedPage> createState() => _DetailSpecializedPageState();
}

class _DetailSpecializedPageState extends State<DetailSpecializedPage> {
  final logic = Get.put(DetailSpecializedLogic());
  final state = Get.find<DetailSpecializedLogic>().state;


  @override
  void initState() {
    logic.initData(widget.specializedResponse);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<DetailSpecializedLogic>();
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
          preferredSize: const Size.fromHeight(AppDimens.spacingNormal),
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.spacingNormal,
          vertical: AppDimens.spacingNormal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.grayColor, width: 1)),
              child: Text(
                'Code: ${widget.specializedResponse.code??'Unknown'}',
                style: AppTextStyle.color3C3A36S16W500,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.grayColor, width: 1)),
              child: Obx(() {
                return Text(
                  'Name: ${state.specialized.value.name ?? ''}',
                  style: AppTextStyle.color3C3A36S16W500,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                );
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.grayColor, width: 1)),
              child: Obx((){
                return Text(
                  'Display name: ${state.specialized.value.displayName ?? ''}',
                  style: AppTextStyle.color3C3A36S16W500,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                );
              }),
            )
          ],
        ),
      ),
    );
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
        Image.asset(
          widget.specializedResponse.icon ?? AppImages.icSpecialized1,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Obx(() {
            return Text(
              state.specialized.value.name ?? '',
              style: AppTextStyle.colorDarkS24W500,
            );
          }),
        ),
        DropdownButton<String>(
          items: <String>['Update', 'Delete'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyle.colorDarkS16W500,
              ),
            );
          }).toList(),
          onChanged: (_) {
            if (_ == 'Delete') {
              _showDialogDelete();
            } else if (_ == 'Update') {
              Get.to(UpdateSpecializedPage(
                specializedResponse: widget.specializedResponse,
                callback: (value) {
                  state.specialized.value = value;
                  state.specialized.refresh();
                },
              ));
            }
          },
          icon: const Icon(Icons.more_vert),
          underline: Container(),
        ),
        const SizedBox(
          width: AppDimens.spacingNormal,
        ),
      ],
    );
  }

  void _showDialogDelete() {
    showDialog(
        context: context,
        builder: (BuildContext c) {
          return AlertDialog(
            title: Text(
              'Notification',
              style: AppTextStyle.colorDarkS20W500,
            ),
            content: Text(
              'Do you want to delete specialized. Please confirm',
              style: AppTextStyle.colorDarkS16W500,
            ),
            actions: [
              FlatButton(
                child: Text(
                  'Cancel',
                  style: AppTextStyle.colorPrimaryS16,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              FlatButton(
                child: Text(
                  'OK',
                  style: AppTextStyle.colorPrimaryS16,
                ),
                onPressed: () {
                  logic.deleteSpecialized(
                    id: widget.specializedResponse.id,
                  );
                },
              ),
            ],
          );
        });
  }
}
