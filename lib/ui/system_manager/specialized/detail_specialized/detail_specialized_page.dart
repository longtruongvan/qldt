import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_images.dart';
import 'package:qldt/model/response/specialized_response.dart';

import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../widgets/button/back_button.dart';
import '../../../widgets/textfields/app_text_field.dart';
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
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.grayColor, width: 1)),
              child: Text(
                'Name: ${widget.specializedResponse.name}',
                style: AppTextStyle.colorDarkS16W500
                    .copyWith(color: AppColors.grayColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.grayColor, width: 1)),
              child: Text(
                'Display name: ${widget.specializedResponse.displayName}',
                style: AppTextStyle.colorDarkS16W500
                    .copyWith(color: AppColors.grayColor),
              ),
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
        Image.asset(widget.specializedResponse.icon??AppImages.icSpecialized1,width: 24,height: 24,),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            "${widget.specializedResponse.displayName}",
            style: AppTextStyle.colorDarkS24W500,
          ),
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
