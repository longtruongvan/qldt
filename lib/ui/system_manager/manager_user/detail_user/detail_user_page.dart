import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/model/response/person_response.dart';
import 'package:qldt/ui/system_manager/manager_user/detail_user/detail_user_logic.dart';

import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../widgets/button/back_button.dart';

class DetailUserPage extends StatefulWidget {
  final PersonResponse personResponse;

  const DetailUserPage({
    Key? key,
    required this.personResponse,
  }) : super(key: key);

  @override
  State<DetailUserPage> createState() => _DetailUserPageState();
}

class _DetailUserPageState extends State<DetailUserPage> {
  final logic = Get.put(DetailUserLogic());
  final state = Get.find<DetailUserLogic>().state;
  final String _avatarPlaceholder =
      'https://firebasestorage.googleapis.com/v0/b/flutter-app-151a6.appspot.com/o/leaves-7101716_1280.png?alt=media&token=7474428c-854f-4494-ad1f-ec60cc675415';
  String _nameUser = '';

  @override
  void dispose() {
    Get.delete<DetailUserLogic>();
    super.dispose();
  }

  @override
  void initState() {
    logic.getData(widget.personResponse);
    _nameUser = (widget.personResponse.name ?? '').replaceAll('@gmail.com', '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppbarWidget(),
            _buildHeaderWidget(),
            ListView(
              shrinkWrap: true,
              children: [
                Obx(
                      () {
                    String title = '';
                    if (state.classResponse.value.name != null) {
                      title = state.classResponse.value.name!;
                    }
                    return _buildItemInfoWidget(
                      title,
                      Icons.class_,
                    );
                  },
                ),
                Obx(
                      () {
                    String title = '';
                    if (state.specializedResponse.value.name != null) {
                      title = state.specializedResponse.value.name!;
                    }
                    return _buildItemInfoWidget(
                      title,
                      Icons.subject,
                    );
                  },
                ),
                _buildItemInfoWidget(
                  widget.personResponse.phone ?? '',
                  Icons.phone,
                ),
                _buildItemInfoWidget(
                  widget.personResponse.email ?? '',
                  Icons.mail,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItemInfoWidget(String title, IconData iconData) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.spacingNormal),
        ),
        child: Container(
          margin: const EdgeInsets.all(AppDimens.spacingNormal),
          child: Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.grayColor.withOpacity(0.5),
                  ),
                  child: Icon(iconData)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  (title == '') ? 'unknown' : title,
                  style: AppTextStyle.color3C3A36S16W500,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderWidget() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(AppDimens.spacingNormal),
      margin: const EdgeInsets.all(AppDimens.spacingNormal),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAvatarWidget(),
          const SizedBox(height: 10),
          Text(
            _nameUser,
            style: AppTextStyle.colorDarkS20W500,
          ),
          Text(
            widget.personResponse.email ?? '',
            style: AppTextStyle.colorGrayS14W500,
          ),
          const SizedBox(height: 30),
          const Divider(height: 2, color: AppColors.grayColor),
        ],
      ),
    );
  }

  Widget _buildAvatarWidget() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AppColors.grayColor,
          width: 3,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.network(widget.personResponse.avatar ?? _avatarPlaceholder,
            fit: BoxFit.cover),
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
        Expanded(
          child: Text(
            "Detail user",
            style: AppTextStyle.colorDarkS24W500,
          ),
        ),
        const SizedBox(
          width: AppDimens.spacingNormal,
        ),
      ],
    );
  }
}
