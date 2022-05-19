import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_dimens.dart';
import 'package:qldt/common/app_text_style.dart';
import 'package:qldt/ui/system_manager/specialized/specialized_logic.dart';

import '../../widgets/button/back_button.dart';
import 'add_specialized/add_specialized_page.dart';

class SpecializedPage extends StatefulWidget {
  const SpecializedPage({Key? key}) : super(key: key);

  @override
  State<SpecializedPage> createState() => _SpecializedPageState();
}

class _SpecializedPageState extends State<SpecializedPage> {
  final logic = Get.put(SpecializedLogic());
  final state = Get.find<SpecializedLogic>().state;

  @override
  void dispose() {
    Get.delete<SpecializedLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(AppDimens.spacingNormal),
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
    return Obx(
      () => Center(
        child: Visibility(
          visible: state.stateLoading.value,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Column(
      children: [
        _buildAppbarWidget(),
        const SizedBox(height: AppDimens.spacingNormal),
        Expanded(
          child: ListView.separated(
            itemBuilder: (c, index) {
              return Container(
                child: const Text("ABC"),
                padding: const EdgeInsets.all(AppDimens.spacingNormal),
              );
            },
            separatorBuilder: (c, index) {
              return const Divider(
                color: AppColors.grayColor,
                height: 1,
              );
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildAppbarWidget() {
    return Row(
      children: [
        AppBackButton(eventHandler: () {
          Get.back();
        }),
        const SizedBox(width: AppDimens.spacingNormal),
        Expanded(
          child: Text(
            "Specialized",
            style: AppTextStyle.colorDarkS24W500,
          ),
        ),
        DropdownButton<String>(
          items: <String>['Add'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyle.colorDarkS16W500,
              ),
            );
          }).toList(),
          onChanged: (_) {
            if (_ == 'Add') {
              Get.to(const AddSpecializedPage());
            }
          },
          icon: const Icon(Icons.more_vert),
          underline: Container(),
        )
      ],
    );
  }
}
