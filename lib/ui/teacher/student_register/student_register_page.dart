import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/model/entity/course_entity.dart';
import 'package:qldt/ui/teacher/student_register/student_register_logic.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_dimens.dart';
import '../../../common/app_images.dart';
import '../../../common/app_text_style.dart';
import '../../widgets/button/back_button.dart';

class StudentRegisterList extends StatefulWidget {
  const StudentRegisterList({Key? key}) : super(key: key);

  @override
  State<StudentRegisterList> createState() => _StudentRegisterListState();
}

class _StudentRegisterListState extends State<StudentRegisterList> {
  final logic = Get.put(StudentRegisterLogic());
  final state = Get.find<StudentRegisterLogic>().state;

  @override
  void dispose() {
    Get.delete<StudentRegisterLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppDimens.spacingNormal),
            _buildAppbarWidget(),
            const SizedBox(height: AppDimens.spacingNormal),
            const Divider(
              height: 1,
              color: AppColors.grayColor,
            ),
            _buildListRegisterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSubjectTitleWidget() {
    return TabBar(
      indicatorColor: Colors.transparent,
      isScrollable: true,
      tabs: state.course.entries.map((response) {
        return Container(
          child: Text(response.key),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
        );
      }).toList(),
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        // Creates border
        color: AppColors.primaryColor,
      ),
      labelColor: AppColors.whiteColor,
      unselectedLabelColor: AppColors.grayColor,
      unselectedLabelStyle:
          const TextStyle(color: AppColors.grayColor, fontSize: 16),
      labelStyle: const TextStyle(color: AppColors.primaryColor, fontSize: 16),
    );
  }

  Widget _buildItemRegisterWidget(int index, CourseEntity value) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(AppDimens.spacingNormal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${value.personResponse?.name}",
                    style: AppTextStyle.colorDarkS16W500,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
                const SizedBox(width: 10),
                (value.subjectRegisterRequest?.isAccept ?? false)
                    ? const Text(
                        'is accept',
                        style: TextStyle(
                          color: AppColors.grayColor,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          value.isAdd=!value.isAdd;
                        },
                        child: (value.isAdd)?const Icon(Icons.remove):const Icon(Icons.add),
                      )
              ],
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildListCourseRegisterWidget() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: AppDimens.spacingNormal),
        child: TabBarView(
          children: state.course.entries.map((map) {
            return ListView.separated(
              itemBuilder: (c, index) {
                return _buildItemRegisterWidget(index, map.value[index]);
              },
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spacingNormal,
              ),
              shrinkWrap: true,
              itemCount: (map.value).length,
              separatorBuilder: (c, index) {
                return const Divider(
                  height: 2,
                  color: AppColors.grayColor,
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildListRegisterWidget() {
    return Expanded(
      child: Obx(
        () => DefaultTabController(
          length: state.course.entries.length,
          child: Column(
            children: [
              const SizedBox(
                height: AppDimens.spacingNormal,
              ),
              Container(
                  padding: const EdgeInsets.only(
                    left: AppDimens.spacingNormal,
                  ),
                  child: _buildTabSubjectTitleWidget()),
              _buildListCourseRegisterWidget()
            ],
          ),
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
          Get.back();
        }),
        const SizedBox(width: AppDimens.spacingNormal),
        Expanded(
          child: Text(
            "List register",
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
