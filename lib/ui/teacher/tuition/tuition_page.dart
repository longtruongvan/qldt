import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/ui/teacher/tuition/create_tution/create_tuition_page.dart';
import 'package:qldt/ui/teacher/tuition/detail_tution/detail_tuition_page.dart';
import 'package:qldt/ui/teacher/tuition/search_tution/search_tuition_page.dart';
import 'package:qldt/ui/teacher/tuition/tuition_logic.dart';

import '../../../common/app_dimens.dart';
import '../../../common/app_images.dart';
import '../../../common/app_text_style.dart';
import '../../../model/response/person_response.dart';
import '../../widgets/button/back_button.dart';
import '../../widgets/textfields/app_text_field.dart';

class TuitionPage extends StatefulWidget {
  const TuitionPage({Key? key}) : super(key: key);

  @override
  State<TuitionPage> createState() => _TuitionPageState();
}

class _TuitionPageState extends State<TuitionPage> {
  final logic = Get.put(TuitionLogic());
  final state = Get.find<TuitionLogic>().state;

  @override
  void dispose() {
    Get.delete<TuitionLogic>();
    super.dispose();
  }

  Widget _buildSearchWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimens.spacingNormal,
        vertical: AppDimens.spacingNormal,
      ),
      child: AppTextField(
        controller: state.searchTextController,
        hintText: 'Search',
        hintStyle: AppTextStyle.colorGrayS14W500,
        suffixIcon: const Icon(
          Icons.search,
          size: 24,
          color: AppColors.grayColor,
        ),
        onChanged: (value) {
          logic.searchHandler(value);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppbarWidget(),
                _buildSearchTitleWidget(),
                _buildSearchWidget(),
                _buildSearchAdvanceWidget(),
                const SizedBox(
                  height: AppDimens.spacingNormal,
                ),
                Expanded(child: _buildBodyWidget()),
              ],
            ),
            // Positioned(
            //   child: _buildButtonSubmitWidget(),
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTitleWidget() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
        child: const Text(
          'Search',
          style: TextStyle(
              color: AppColors.color3C3A36,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ));
  }

  Widget _buildSearchAdvanceWidget() {
    return GestureDetector(
      onTap: () {
        Get.to(const SearchTuitionPage());
      },
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
        child: Row(
          children: const [
            Text(
              'Search advance',
              style: TextStyle(
                  color: AppColors.color3C3A36,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Icon(
              Icons.arrow_right_alt_sharp,
              size: 30,
              color: AppColors.color3C3A36,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    logic.fetchData();
  }

  Widget _buildBodyWidget() {
    return Obx(() {
      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.separated(
          itemBuilder: (c, index) {
            return _buildItemPersonWidget(index);
          },
          itemCount: state.listPersonResponse.length,
          separatorBuilder: (c, index) {
            return Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppDimens.spacingNormal),
              child: const Divider(
                height: 1,
                color: AppColors.grayColor,
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildItemPersonWidget(int index) {
    return GestureDetector(
      onTap: () {
        List<PersonResponse> list = [state.listPersonResponse[index]];
        Get.to(DetailTuitionPage(personResponse: list));
      },
      child: Container(
        padding: const EdgeInsets.all(AppDimens.spacingNormal),
        margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  AppImages.imgUser,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: AppDimens.spacingNormal),
            Expanded(
              child: Text(
                state.listPersonResponse[index].name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.navigate_next,
              color: AppColors.color3C3A36,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAppbarWidget() {
    return Container(
      padding: const EdgeInsets.only(
          bottom: AppDimens.spacingNormal, top: AppDimens.spacingNormal),
      child: Row(
        children: [
          const SizedBox(
            width: AppDimens.spacingNormal,
          ),
          AppBackButton(eventHandler: () {
            Get.back();
          }),
          const SizedBox(width: AppDimens.spacingNormal),
          Text(
            "Tuition manager",
            style: AppTextStyle.colorDarkS24W500,
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Get.to(const CreateTuitionPage());
            },
            child: const Icon(
              Icons.add_circle,
              color: AppColors.successColor,
            ),
          ),
          const SizedBox(
            width: AppDimens.spacingNormal,
          ),
        ],
      ),
    );
  }
}
