import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_images.dart';
import 'package:qldt/model/response/building_response.dart';
import 'package:qldt/model/response/department_response.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/detail_department/detail_department_logic.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/update_department/update_department_page.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/button/back_button.dart';

class DetailDepartmentPage extends StatefulWidget {
  final DepartmentResponse departmentResponse;
  final BuildingResponse buildingResponse;
  final List<BuildingResponse> listBuildingResponse;
  final Function() callback;
  final bool isSystemManager;

  const DetailDepartmentPage({
    Key? key,
    required this.departmentResponse,
    required this.buildingResponse,
    required this.listBuildingResponse,
    required this.callback,
    required this.isSystemManager,
  }) : super(key: key);

  @override
  State<DetailDepartmentPage> createState() => _DetailDepartmentPageState();
}

class _DetailDepartmentPageState extends State<DetailDepartmentPage> {
  final logic = Get.put(DetailDepartmentLogic());
  final state = Get.find<DetailDepartmentLogic>().state;

  @override
  void initState() {
    logic.fetchData(
        departmentResponse: widget.departmentResponse,
        buildingResponse: widget.buildingResponse,
        listBuildingResponse: widget.listBuildingResponse,
        callback: () {});
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<DetailDepartmentLogic>();
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
      body: SafeArea(
        child: Container(
          color: AppColors.whiteColor,
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
          child: Stack(
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
    return Obx(() => Center(
          child: Visibility(
            visible: state.statusLoading.value,
            child: const CircularProgressIndicator(),
          ),
        ));
  }

  Widget _buildBodyWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: AppDimens.spacingNormal,
          ),
          _buildImageClassroomWidget(),
          const SizedBox(
            height: AppDimens.spacingNormal,
          ),
          _buildBookNowButtonWidget(),
          Obx(() => _buildInfoItemRowWidget(
                '${S.of(context).common_status}: ',
                (state.departmentResponse.value.status ?? false)
                    ? 'Online'
                    : 'Offline',
              )),
          Obx(() => _buildInfoItemRowWidget(
              '${S.of(context).name}: ', '${state.departmentResponse.value.name}')),
          Obx(() => _buildInfoItemRowWidget(
              '${S.of(context).update_department_building}: ', state.departmentResponse.value.nameBuilding ?? '')),
          Obx(() => _buildInfoItemRowWidget(
              S.of(context).update_department_location, '${state.departmentResponse.value.location}')),
          Obx(() => _buildInfoItemRowWidget('${S.of(context).update_department_description} ',
              '${state.departmentResponse.value.description}')),
        ],
      ),
    );
  }

  Widget _buildBookNowButtonWidget() {
    return GestureDetector(
      onTap: () {
        if (state.departmentResponse.value.status ?? false) {
          showDialog(
              context: context,
              builder: (BuildContext c) {
                return AlertDialog(
                  title: Text(
                    S.of(context).common_notification,
                    style: AppTextStyle.colorDarkS20W500,
                  ),
                  content: Text(
                    S.of(context).youCantBookThisRoomBecauseSomeoneAlreadyBooked,
                    style: AppTextStyle.colorDarkS16W500,
                  ),
                  actions: [
                    FlatButton(
                      child: Text(
                        'OK',
                        style: AppTextStyle.colorPrimaryS16,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                );
              });
          return;
        }
        logic.bookClassroomHandler(
            id: state.departmentResponse.value.id ?? '',
            callback: () {
              widget.callback();
            });
      },
      child: Row(
        children: [
          const Spacer(),
          Obx(() => Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (state.departmentResponse.value.status ?? false)
                      ? AppColors.grayColor
                      : Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.add,
                      color: AppColors.whiteColor,
                      size: 20,
                    ),
                    Text(
                      S.of(context).bookNow,
                      style: AppTextStyle.colorWhiteS14W500,
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildImageClassroomWidget() {
    return SizedBox(
      height: 200,
      width: Get.width,
      child: ClipRRect(
        child: Image.asset(AppImages.imgClassroom, fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _buildInfoItemRowWidget(String title, String content) {
    return Column(
      children: [
        const SizedBox(
          height: AppDimens.spacingNormal,
        ),
        Row(
          children: [
            Text(
              title,
              style: AppTextStyle.colorDarkS16W500,
            ),
            Text(
              content,
              style: AppTextStyle.colorPrimaryS16,
            ),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          width: Get.width,
          height: 1,
          color: AppColors.grayColor,
        )
      ],
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
          child: Obx(
            () => Text(
              'P: ${(state.departmentResponse.value.name != null) ? state.departmentResponse.value.name : widget.departmentResponse.name}',
              style: AppTextStyle.colorDarkS24W500,
            ),
          ),
        ),
        Visibility(
          child: DropdownButton<String>(
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
                Get.to(
                  UpdateDepartmentPage(
                    departmentResponse: widget.departmentResponse,
                    buildingResponse: widget.buildingResponse,
                    callback: () {
                      widget.callback();
                    },
                  ),
                );
              }
            },
            icon: const Icon(Icons.more_vert),
            underline: Container(),
          ),
          visible: widget.isSystemManager,
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
              S.of(context).common_notification,
              style: AppTextStyle.colorDarkS20W500,
            ),
            content: Text(
              S.of(context).doYouWantToDeleteThisDepartmentPleaseConfirm,
              style: AppTextStyle.colorDarkS16W500,
            ),
            actions: [
              FlatButton(
                child: Text(
                  S.of(context).common_cancel,
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
                  logic.deleteClassroom(
                      id: widget.departmentResponse.id ?? '',
                      callback: () {
                        widget.callback();
                      });
                },
              ),
            ],
          );
        });
  }
}
