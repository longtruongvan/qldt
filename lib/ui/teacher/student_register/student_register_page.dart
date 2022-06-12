import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/model/entity/course_entity.dart';
import 'package:qldt/model/request/subject_register_request.dart';
import 'package:qldt/ui/teacher/student_register/create_time_table/create_time_table_page.dart';
import 'package:qldt/ui/teacher/student_register/student_register_logic.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_dimens.dart';
import '../../../common/app_images.dart';
import '../../../common/app_text_style.dart';
import '../../../generated/l10n.dart';
import '../../widgets/button/back_button.dart';

class StudentRegisterList extends StatefulWidget {
  const StudentRegisterList({Key? key}) : super(key: key);

  @override
  State<StudentRegisterList> createState() => _StudentRegisterListState();
}

class _StudentRegisterListState extends State<StudentRegisterList>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(StudentRegisterLogic());
  final state = Get.find<StudentRegisterLogic>().state;
  late TabController _tabController;
  int indexTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: state.course.length, vsync: this);
    _tabController.addListener(() {
      indexTab = _tabController.index;
    });
  }

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
      onTap: (index) {
        indexTab = index;
      },
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

  Widget _buildItemRegisterWidget(
      int index, MapEntry<String, List<CourseEntity>> map) {
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
                    map.value[index].personResponse?.name ?? '',
                    style: AppTextStyle.colorDarkS16W500,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
                const SizedBox(width: 10),
                (state.course[map.key]?[index].subjectRegisterRequest
                            ?.isAccept ??
                        false)
                    ? Text(
                        S.of(context).isAccept,
                        style: const TextStyle(
                          color: AppColors.successColor,
                        ),
                      )
                    // : GestureDetector(
                    //     onTap: () {
                    //       state.course[map.key]?[index].isAdd =
                    //           !(state.course[map.key]?[index].isAdd ?? false);
                    //       state.course.refresh();
                    //     },
                    //     child: (state.course[map.key]?[index].isAdd ?? false)
                    //         ? const Icon(Icons.remove)
                    //         : const Icon(Icons.add),
                    //   )
                    : Container()
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
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (c, index) {
                      return _buildItemRegisterWidget(index, map);
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
                  ),
                ),
                _buildButtonSubmitWidget(logic.checkHideOrShowButtonSubmit(map.value)),
              ],
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
                child: _buildTabSubjectTitleWidget(),
              ),
              _buildListCourseRegisterWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonSubmitWidget(bool status) {
    if(status){
      return Container();
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
      color: AppColors.whiteColor,
      child: GestureDetector(
        onTap: () {
          int count = 0;
          List<CourseEntity> listCourseEntity = [];
          state.course.forEach((key, value) {
            if (count == indexTab) {
              listCourseEntity.addAll(value);
            }
            count++;
          });
          Get.to(CreateTimeTablePage(
            title: listCourseEntity.first.subjectResponse?.name ?? '',
            listCourseEntity: listCourseEntity,
            callback: () {
              logic.fetchData();
            },
          ));
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(20)),
          height: 60,
          child: Center(
              child: Text(
            S.current.common_ok,
            style: AppTextStyle.colorWhiteS16
                .copyWith(fontWeight: FontWeight.w500),
          )),
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
            S.of(context).student_register_list_register,
            style: AppTextStyle.colorDarkS24W500,
          ),
        ),
        const SizedBox(
          width: AppDimens.spacingNormal,
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
