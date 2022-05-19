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
import '../../../widgets/button/back_button.dart';

class DetailDepartmentPage extends StatefulWidget {
  final DepartmentResponse departmentResponse;
  final BuildingResponse buildingResponse;
  final List<BuildingResponse> listBuildingResponse;
  final Function() callback;

  const DetailDepartmentPage({
    Key? key,
    required this.departmentResponse,
    required this.buildingResponse,
    required this.listBuildingResponse,
    required this.callback,
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
          preferredSize: const Size.fromHeight(AppDimens.spacingNormal),
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
                'Status: ',
                (state.departmentResponse.value.status ?? false)
                    ? 'Online'
                    : 'Offline',
              )),
          Obx(() => _buildInfoItemRowWidget(
              'Name: ', '${state.departmentResponse.value.name}')),
          Obx(() => _buildInfoItemRowWidget(
              'Building: ', state.buildingResponse.value.name ?? '')),
          Obx(() => _buildInfoItemRowWidget(
              'Location: ', '${state.departmentResponse.value.location}')),
          Obx(() => _buildInfoItemRowWidget('Description: ',
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
                    'Notification',
                    style: AppTextStyle.colorDarkS20W500,
                  ),
                  content: Text(
                    "You can't book this room, because someone already booked",
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
                      "Book now",
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
        const SizedBox(width: AppDimens.spacingNormal,),
        AppBackButton(eventHandler: () {
          Get.back(closeOverlays: true);
        }),
        const SizedBox(width: AppDimens.spacingNormal),
        Expanded(
          child: Text('P: ${widget.departmentResponse.name}',
              style: AppTextStyle.colorDarkS24W500),
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
              Get.to(
                UpdateDepartmentPage(
                  departmentResponse: widget.departmentResponse,
                  buildingResponse: widget.buildingResponse,
                  callback: (){
                    widget.callback();
                  },
                ),
              );
            }
          },
          icon: const Icon(Icons.more_vert),
          underline: Container(),
        ),
        const SizedBox(width: AppDimens.spacingNormal,),
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
              'Do you want to delete this department? Please confirm.',
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
