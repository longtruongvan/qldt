import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/ui/teacher/teacher_score_manager/view_score/view_score_logic.dart';

import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../../model/response/person_response.dart';
import '../../../widgets/button/back_button.dart';

enum ScoreViewType {
  /// xem diem tong ket
  all,

  /// xem diem mon hoc
  subject
}

class ViewScorePage extends StatefulWidget {
  final List<PersonResponse> students;

  const ViewScorePage({
    Key? key,
    required this.students,
  }) : super(key: key);

  @override
  State<ViewScorePage> createState() => _ViewScorePageState();
}

class _ViewScorePageState extends State<ViewScorePage> {
  final logic = Get.put(ViewScoreLogic());
  final state = Get.find<ViewScoreLogic>().state;

  @override
  void initState() {
    logic.fetchData(widget.students);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ViewScoreLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildBodyWidget(),
            _buildLoadingWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Obx(() {
      if (state.statusLoading.value) {
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        );
      }
      return Container();
    });
  }

  Widget _buildBodyWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAppbarWidget(),
        _buildListStudentWidget(),
      ],
    );
  }

  Widget _buildTablePersonWidget() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),
        3: FlexColumnWidth(3),
      },
      children: [
        TableRow(children: [
          _buildTitleTableWidget('STT'),
          _buildTitleTableWidget('Name'),
          _buildTitleTableWidget('Code'),
          _buildTitleTableWidget('Birth day'),
        ]),
      ],
    );
  }

  Widget _buildTitleTableWidget(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      color: AppColors.primaryColor,
      child: Text(
        text,
        style: AppTextStyle.colorWhiteS14W500,
      ),
    );
  }

  TableRow _buildInfoStudentWidget(
    String title,
    String value,
    bool isEditText,
  ) {
    return TableRow(children: [
      Container(
        margin: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
        child: Text(
          title,
          style: AppTextStyle.color3C3A36S16W500
              .copyWith(color: AppColors.primaryColor),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
        child: (isEditText)
            ? TextField(
                controller: TextEditingController(text: value),
                enableSuggestions: false,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                style: AppTextStyle.color3C3A36S16W500
                    .copyWith(color: AppColors.primaryColor),
              )
            : Text(
                value,
                style: AppTextStyle.color3C3A36S16W500.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
      ),
    ]);
  }

  Widget _buildActionInfoStudentWidget() {
    return Row(children: [
      const Spacer(),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grayColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.edit, size: 18, color: AppColors.grayColor),
            const SizedBox(width: 5),
            Text('Edit', style: AppTextStyle.colorGrayS14W500),
          ],
        ),
      ),
      const SizedBox(width: AppDimens.spacingNormal),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grayColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.remove, size: 18, color: AppColors.grayColor),
            const SizedBox(width: 5),
            Text('Remove', style: AppTextStyle.colorGrayS14W500),
          ],
        ),
      ),
      const SizedBox(width: AppDimens.spacingNormal),
    ]);
  }

  Widget _buildListStudentWidget() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          shrinkWrap: true,
          itemBuilder: (c, index) {
            return Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppDimens.spacingNormal),
              child: Card(
                child: ExpansionTile(
                  children: [
                    Table(
                      border: const TableBorder(
                        horizontalInside: BorderSide(
                          width: 0.5,
                          color: AppColors.grayColor,
                          style: BorderStyle.solid,
                        ),
                        verticalInside: BorderSide(
                          width: 0.5,
                          color: AppColors.grayColor,
                          style: BorderStyle.solid,
                        ),
                      ),
                      columnWidths: const {
                        0: FlexColumnWidth(4),
                        1: FlexColumnWidth(6),
                      },
                      children: state.viewType.value == ScoreViewType.all
                          ? [
                              _buildInfoStudentWidget(
                                  'Code:',
                                  state.listScoreEntity[index].personResponse
                                          ?.idClass ??
                                      '',
                                  false),
                              _buildInfoStudentWidget(
                                  'Birthday:',
                                  state.listScoreEntity[index].personResponse
                                          ?.birthday ??
                                      '',
                                  false),
                              _buildInfoStudentWidget(
                                  'TBTL Hệ 10 N1:', '10', true),
                              _buildInfoStudentWidget(
                                  'TBTL Hệ4 N1:', '10', true),
                              _buildInfoStudentWidget(
                                  'Số TCTL N1:', '10', true),
                              _buildInfoStudentWidget('Số TC N1:', '10', true),
                            ]
                          : [
                              _buildInfoStudentWidget(
                                  'Code:',
                                  state.listScoreEntity[index].personResponse
                                          ?.idClass ??
                                      '',
                                  false),
                              _buildInfoStudentWidget(
                                  'Birthday:',
                                  state.listScoreEntity[index].personResponse
                                          ?.birthday ??
                                      '',
                                  false),
                              _buildInfoStudentWidget('CC:', '10', true),
                              _buildInfoStudentWidget('KT:', '10', true),
                              _buildInfoStudentWidget('THI:', '10', true),
                              _buildInfoStudentWidget('KTHP:', '10', true),
                              _buildInfoStudentWidget('Chữ:', 'A', true),
                              _buildInfoStudentWidget('Đánh giá:', 'Đạt', true),
                            ],
                    ),
                    const SizedBox(height: AppDimens.spacingNormal),
                    _buildActionInfoStudentWidget(),
                    const SizedBox(height: AppDimens.spacingNormal),
                  ],
                  title: Text(
                    '#${index + 1}. Truơng Văn Long',
                    style: AppTextStyle.color3C3A36S18W500,
                  ),
                ),
              ),
            );
          },
          itemCount: state.listScoreEntity.length,
        );
      }),
    );
  }

  Widget _buildWidgetSelectSemester() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.spacingNormal),
          border: Border.all(color: AppColors.grayColor, width: 1),
        ),
        child: DropdownButton2(
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.grayColor,
          ),
          underline: Container(
            color: AppColors.whiteColor,
          ),
          value: 'All',
          hint: Text('Select year', style: AppTextStyle.colorGrayS14W500),
          onChanged: (value) {
            // logic.checkPersonSelected(value as String);
          },
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.spacingNormal),
          ),
          offset: const Offset(0, -AppDimens.spacingNormal),
          items: [
            DropdownMenuItem<String>(
              child: Text(
                'All',
                style: AppTextStyle.color3C3A36S14W500,
              ),
              value: 'All',
            ),
            DropdownMenuItem<String>(
              child: Text(
                '1',
                style: AppTextStyle.color3C3A36S14W500,
              ),
              value: '1',
            ),
            DropdownMenuItem<String>(
              child: Text(
                '2',
                style: AppTextStyle.color3C3A36S14W500,
              ),
              value: '2',
            ),
          ],
        ));
  }

  Widget _buildWidgetSelectYear() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.spacingNormal),
          border: Border.all(color: AppColors.grayColor, width: 1),
        ),
        child: DropdownButton2(
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.grayColor,
          ),
          underline: Container(
            color: AppColors.whiteColor,
          ),
          value: 'All',
          hint: Text('Select year', style: AppTextStyle.colorGrayS14W500),
          onChanged: (value) {
            // logic.checkPersonSelected(value as String);
          },
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.spacingNormal),
          ),
          offset: const Offset(0, -AppDimens.spacingNormal),
          items: [
            DropdownMenuItem<String>(
              child: Text(
                'All',
                style: AppTextStyle.color3C3A36S14W500,
              ),
              value: 'All',
            ),
            DropdownMenuItem<String>(
              child: Text(
                '2019',
                style: AppTextStyle.color3C3A36S14W500,
              ),
              value: '2019',
            ),
            DropdownMenuItem<String>(
              child: Text(
                '2018',
                style: AppTextStyle.color3C3A36S14W500,
              ),
              value: '2018',
            ),
          ],
        ));
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
            "Score",
            style: AppTextStyle.colorDarkS24W500,
          ),
        ],
      ),
    );
  }
}
