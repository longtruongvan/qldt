import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/services/setting_service.dart';
import 'package:qldt/ui/setting/setting_logic.dart';

import '../../common/app_dimens.dart';
import '../../common/app_text_style.dart';
import '../../generated/l10n.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final logic = Get.put(SettingLogic());
  final state = Get.find<SettingLogic>().state;
  final settingService = Get.find<SettingService>();

  @override
  void dispose() {
    Get.delete<SettingLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: _buildAppbarWidget(),
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      body: Container(
        padding: const EdgeInsets.all(AppDimens.spacingNormal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(S.of(context).theme, style: AppTextStyle.color3C3A36S24), // chủ đề
            // Obx(
            //   () => _buildItemRadioButtonWidget1(
            //       S.of(context).system, ThemeMode.light, settingService.currentThemeMode.value, (value) {
            //     settingService.changeTheme(value);
            //   }),
            // ),
            // Obx(
            //   () => _buildItemRadioButtonWidget1(
            //       S.of(context).light, 2, settingService.currentThemeMode.value, (value) {
            //     settingService.changeTheme(value);
            //   }),
            // ),
            // Obx(
            //   () => _buildItemRadioButtonWidget1(
            //       S.of(context).dark, 3, settingService.currentThemeMode.value, (value) {
            //     settingService.changeTheme(value);
            //   }),
            // ),
            Text(S.of(context).language, style: AppTextStyle.color3C3A36S24),
            Obx(
              () => _buildItemRadioButtonWidget(
                  S.of(context).english, const Locale.fromSubtags(languageCode: 'en'), settingService.currentLocale.value, (value) {
                settingService.changeLanguage(value);
              }),
            ),
            Obx(
              () => _buildItemRadioButtonWidget(
                  S.of(context).vietnamese,const Locale.fromSubtags(languageCode: 'vi'), settingService.currentLocale.value, (value) {
                settingService.changeLanguage(value);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRadioButtonWidget1(
    String title,
    String value,
    String groupValue,
    Function(String) onchangeValue,
  ) {
    return RadioListTile(
      value: value,
      groupValue: groupValue,
      onChanged: (value1) {
        onchangeValue(value);
      },
      activeColor: AppColors.primaryColor,
      title: Text(title, style: AppTextStyle.color3C3A36S18),
    );
  }

  Widget _buildItemRadioButtonWidget(
      String title,
      Locale value,
      Locale groupValue,
      Function(Locale) onchangeValue,
      ) {
    return RadioListTile(
      value: value,
      groupValue: groupValue,
      onChanged: (value1) {
        onchangeValue(value);
      },
      activeColor: AppColors.primaryColor,
      title: Text(title, style: AppTextStyle.color3C3A36S18),
    );
  }

  Widget _buildAppbarWidget() {
    return Container(
      color: AppColors.primaryColor,
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: AppDimens.spacingNormal),
          Text(
            S.of(context).setting??'',
            style: AppTextStyle.colorDarkS24W500.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
          const Spacer(),
          const SizedBox(width: AppDimens.spacingNormal),
        ],
      ),
    );
  }
}
