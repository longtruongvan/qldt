import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:qldt/ui/teacher/update_infomation/update_infomation_logic.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_dimens.dart';
import '../../../common/app_images.dart';
import '../../../common/app_text_style.dart';
import '../../../services/auth_service.dart';
import '../../widgets/button/app_button.dart';
import '../../widgets/textfields/app_text_field.dart';

class UpdateInfomationPage extends StatefulWidget {
  final Function() callback;
  const UpdateInfomationPage({Key? key,required this.callback}) : super(key: key);

  @override
  State<UpdateInfomationPage> createState() => _UpdateInfomationState();
}

class _UpdateInfomationState extends State<UpdateInfomationPage> {
  final logic = Get.put(UpdateInfomationLogic());
  final state = Get.find<UpdateInfomationLogic>().state;
  final authService = Get.find<AuthService>();

  @override
  void dispose() {
    Get.delete<UpdateInfomationLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildBodyWidget(),
          _buildLoadingWidget(),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget(){
    return Container();
  }

  Widget _buildButtonSave() {
    return Positioned(
      child: AppButton(
        title: 'Save',
        onPress: () {
          logic.save((){
            widget.callback();
          });
        },
      ),
      bottom: AppDimens.spacingNormal,
      right: AppDimens.spacingNormal,
      left: AppDimens.spacingNormal,
    );
  }

  Widget _buildBodyWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 120,
              width: Get.width,
              color: AppColors.primaryColor,
            ),
            _buildHeaderWidget(),
            const SizedBox(
              height: AppDimens.spacingNormal,
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(
            top: AppDimens.spacingNormal,
            left: AppDimens.spacingNormal,
            right: AppDimens.spacingNormal,
          ),
          child: Column(
            children: [
              AppTextField(
                controller: state.phoneTextController,
                textStyle: AppTextStyle.colorGrayS16W500,
                hintText: (authService.user.value?.phoneNumber) ??
                    (authService.person.value?.phone) ??
                    'Add phone number',
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone),
              ),
              const SizedBox(
                height: AppDimens.spacingNormal,
              ),
              AppTextField(
                textStyle: AppTextStyle.colorGrayS16W500,
                hintText: (authService.user.value?.email) ??
                    (authService.person.value?.email),
                prefixIcon: const Icon(Icons.email),
                isEnable: false,
              ),
              const SizedBox(
                height: AppDimens.spacingNormal,
              ),
              AppTextField(
                controller: state.locationTextController,
                textStyle: AppTextStyle.colorGrayS16W500,
                hintText: (authService.person.value?.location) ??
                    'Add location',
                prefixIcon: const Icon(Icons.location_pin),
              ),
              const SizedBox(
                height: AppDimens.spacingNormal,
              ),
              _buildButtonSave(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildHeaderWidget() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(
          left: AppDimens.spacingNormal,
          right: AppDimens.spacingNormal,
          top: 20,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Container(
            padding: const EdgeInsets.all(AppDimens.spacingNormal),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${authService.person.value?.name ?? ''},',
                        style: AppTextStyle.colorDarkS16W500.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        authService.user.value?.email ?? '',
                        style: AppTextStyle.colorGrayS14W500.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: ProgressiveImage.assetNetwork(
                    placeholder: AppImages.imgLoading1,
                    placeholderScale: 1.5,
                    thumbnail: (authService.person.value != null &&
                        authService.person.value!.avatar != null)
                        ? authService.person.value!.avatar ??
                        'https://cdn.pixabay.com/photo/2022/05/08/20/21/flowers-7182930_1280.jpg'
                        : 'https://cdn.pixabay.com/photo/2022/05/08/20/21/flowers-7182930_1280.jpg',
                    image: (authService.person.value != null &&
                        authService.person.value!.avatar != null)
                        ? authService.person.value!.avatar ??
                        'https://cdn.pixabay.com/photo/2022/05/08/20/21/flowers-7182930_1280.jpg'
                        : 'https://cdn.pixabay.com/photo/2022/05/08/20/21/flowers-7182930_1280.jpg',
                    fit: BoxFit.cover,
                    width: 48,
                    height: 48,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
