import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/common/app_dimens.dart';
import 'package:qldt/common/app_images.dart';
import 'package:qldt/ui/system_manager/subjects/add_subject/add_subject_page.dart';
import 'package:qldt/ui/system_manager/subjects/detail_subject/detail_subject_page.dart';
import 'package:qldt/ui/system_manager/subjects/subject_logic.dart';
import 'package:qldt/ui/system_manager/subjects/subject_state.dart';

import '../../../common/app_text_style.dart';
import '../../../generated/l10n.dart';
import '../../widgets/button/back_button.dart';
import '../../widgets/textfields/app_text_field.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({Key? key}) : super(key: key);

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  final logic = Get.put(SubjectLogic());
  final state = Get.find<SubjectLogic>().state;

  @override
  void dispose() {
    Get.delete<SubjectLogic>();
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
      body: Container(
        padding: const EdgeInsets.all(AppDimens.spacingNormal),
        color: AppColors.whiteColor,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildBodyWidget(),
            _buildLoadingWidget(),
          ],
        ),
      ),
      backgroundColor: AppColors.whiteColor,
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

  Future _onRefresh() async {
    logic.fetchData();
  }

  Widget _buildBodyWidget() {
    return Column(
      children: [
        _buildSearchWidget(),
        const SizedBox(
          height: AppDimens.spacingNormal,
        ),
        Expanded(
          child: Obx(() => RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  itemBuilder: (c, index) {
                    return _buildItemSubject(index);
                  },
                  itemCount: state.listSubject.length,
                ),
              )),
        ),
      ],
    );
  }

  Widget _buildSearchWidget() {
    return AppTextField(
      controller: state.searchTextController,
      hintText: S.of(context).common_search,
      hintStyle: AppTextStyle.colorGrayS14W500,
      suffixIcon: const Icon(
        Icons.search,
        size: 24,
        color: AppColors.grayColor,
      ),
      onChanged: (value) {
        logic.searchHandler(value);
      },
    );
  }

  Widget _buildItemSubject(int index) {
    return InkWell(
      onTap: () {
        Get.to(DetailSubjectPage(
          subjectResponse: state.listSubject[index],
          callback: (response) {
            logic.updateSubject(response);
          },
        ));
      },
      child: Column(
        children: [
          const SizedBox(height: AppDimens.spacingNormal),
          Row(
            children: [
              Image.asset(
                state.listSubject[index].icon ?? AppImages.icSpecialized1,
                width: 24,
                height: 24,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  '${state.listSubject[index].name}',
                  style: AppTextStyle.colorDarkS16W500,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.navigate_next_sharp,
                color: AppColors.darkColor,
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spacingNormal),
          const Divider(
            color: AppColors.grayColor,
            height: 1,
          ),
        ],
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
          child: Text(S.of(context).subjects, style: AppTextStyle.colorDarkS24W500),
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
              Get.to(AddSubjectPage(
                callback: (id) {
                  logic.getSubjectById(id);
                },
              ));
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
}
