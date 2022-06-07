import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/model/response/class_response.dart';
import 'package:qldt/ui/system_manager/manager_user/select_class/select_class_logic.dart';

import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/button/back_button.dart';

class SelectClassPage extends StatefulWidget {
  final Function(ClassResponse) callback;

  const SelectClassPage({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  State<SelectClassPage> createState() => _SelectClassPageState();
}

class _SelectClassPageState extends State<SelectClassPage> {
  final logic = Get.put(SelectClassLogic());
  final state = Get.find<SelectClassLogic>().state;

  @override
  void dispose() {
    Get.delete<SelectClassLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppDimens.spacingNormal),
                    _buildAppbarWidget(),
                    const SizedBox(height: AppDimens.spacingNormal),
                    const Divider(height: 1, color: AppColors.grayColor),
                    const SizedBox(height: AppDimens.spacingNormal),
                    Obx(() => Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimens.spacingNormal,
                            ),
                            itemBuilder: (c, index) {
                              return GestureDetector(
                                onTap: (){
                                  widget.callback(state.listClass[index]);
                                  Get.back();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(
                                      AppDimens.spacingNormal),
                                  child: Text(
                                    state.listClass[index].name ?? '',
                                    style: AppTextStyle.color3C3A36S18W500,
                                  ),
                                ),
                              );
                            },
                            itemCount: state.listClass.length,
                            separatorBuilder: (c, index) {
                              return const Divider(
                                color: AppColors.grayColor,
                                height: 1,
                              );
                            },
                          ),
                        )),
                  ],
                ),
              ),
              _buildLoadingWidget(),
            ],
          ),
        ),
      ),
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
          child: Text(S.of(context).common_select_class,
              style: AppTextStyle.colorDarkS24W500),
        ),
      ],
    );
  }
}
