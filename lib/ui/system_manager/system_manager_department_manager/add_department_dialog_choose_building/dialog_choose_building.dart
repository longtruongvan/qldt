import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/model/response/building_response.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_style.dart';
import '../../../../generated/l10n.dart';

class DialogChooseBuilding extends StatefulWidget {
  final List listBuilding;
  final Function(BuildingResponse) callback;

  const DialogChooseBuilding({
    Key? key,
    required this.listBuilding,
    required this.callback,
  }) : super(key: key);

  @override
  State<DialogChooseBuilding> createState() => _DialogChooseBuildingState();
}

class _DialogChooseBuildingState extends State<DialogChooseBuilding> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        S.of(context).common_select_building,
        style: AppTextStyle.colorDarkS16W500,
      ),
      content: SizedBox(
        width: Get.width * 0.45,
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (c, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  for (int i = 0; i < widget.listBuilding.length; i++) {
                    if (i == index) {
                      widget.listBuilding[i].isSelected = true;
                    } else {
                      widget.listBuilding[i].isSelected = false;
                    }
                  }
                });
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Text(widget.listBuilding[index].name),
                    const Spacer(),
                    Icon(
                      Icons.check,
                      color: (widget.listBuilding[index].isSelected ?? false)
                          ? AppColors.primaryColor
                          : Colors.transparent,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
              ),
            );
          },
          separatorBuilder: (c, index) {
            return const Divider(
              color: AppColors.grayColor,
            );
          },
          itemCount: widget.listBuilding.length,
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            for (int i = 0; i < widget.listBuilding.length; i++) {
              if (widget.listBuilding[i].isSelected ?? false) {
                widget.callback(widget.listBuilding[i]);
              }
            }
            Get.back();
          },
          child: Text(
            "OK",
            style: AppTextStyle.colorDarkS16W500.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
