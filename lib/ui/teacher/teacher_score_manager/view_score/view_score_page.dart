import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qldt/common/app_colors.dart';
import 'package:qldt/model/response/subject_response.dart';
import 'package:qldt/services/auth_service.dart';
import 'package:qldt/ui/splash/splash_logic.dart';
import 'package:qldt/ui/teacher/teacher_score_manager/view_score/view_score_logic.dart';

import '../../../../common/app_dimens.dart';
import '../../../../common/app_text_style.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/response/person_response.dart';
import '../../../widgets/button/back_button.dart';
import '../teacher_score_manager_page.dart';

enum ScoreViewType {
  /// xem diem tong ket
  all,

  /// xem diem mon hoc
  subject
}

class ViewScorePage extends StatefulWidget {
  final List<PersonResponse> students;
  final List<PersonResponse> currentListStudent;
  final ScoreViewType viewType;
  final SubjectResponse subjectResponse;
  final TypeScoreManager typeScoreManager;

  const ViewScorePage({
    Key? key,
    required this.students,
    required this.currentListStudent,
    required this.viewType,
    required this.subjectResponse,
    required this.typeScoreManager,
  }) : super(key: key);

  @override
  State<ViewScorePage> createState() => _ViewScorePageState();
}

class _ViewScorePageState extends State<ViewScorePage> {
  final logic = Get.put(ViewScoreLogic());
  final state = Get.find<ViewScoreLogic>().state;
  final authService = Get.find<AuthService>();

  @override
  void initState() {
    logic.fetchData(widget.students, widget.viewType, widget.subjectResponse);
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
          _buildTitleTableWidget(S.of(context).stt),
          _buildTitleTableWidget(S.of(context).name),
          _buildTitleTableWidget(S.of(context).common_code),
          _buildTitleTableWidget(S.of(context).birthDay),
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

  TableRow _buildInfoStudentWidget(String title, String value, bool isEditText,
      {TextEditingController? controller, TextInputType? textInputType}) {
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
                controller: controller,
                enableSuggestions: false,
                keyboardType: textInputType ?? TextInputType.text,
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

  Widget _buildActionInfoStudentWidget(int index) {
    if (widget.typeScoreManager == TypeScoreManager.student) {
      return Container();
    }
    return Row(children: [
      const Spacer(),
      InkWell(
        onTap: () {
          if (state.listScoreEntity[index].isEdit ?? false) {
            state.listScoreEntity[index].isEdit = false;
            state.listScoreEntity.refresh();
            logic.updateScore(index, () {});
            return;
          }
          state.listScoreEntity[index].isEdit = true;
          state.listScoreEntity.refresh();
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: (state.listScoreEntity[index].isEdit ?? false)
                  ? AppColors.primaryColor
                  : AppColors.grayColor,
            ),
            borderRadius: BorderRadius.circular(10),
            color: (state.listScoreEntity[index].isEdit ?? false)
                ? AppColors.primaryColor
                : Colors.transparent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                (state.listScoreEntity[index].isEdit ?? false)
                    ? Icons.save
                    : Icons.edit,
                size: 18,
                color: (state.listScoreEntity[index].isEdit ?? false)
                    ? AppColors.whiteColor
                    : AppColors.grayColor,
              ),
              const SizedBox(width: 5),
              Text(
                  (state.listScoreEntity[index].isEdit ?? false)
                      ? S.of(context).save
                      : S.of(context).edit,
                  style: AppTextStyle.colorGrayS14W500.copyWith(
                    color: (state.listScoreEntity[index].isEdit ?? false)
                        ? AppColors.whiteColor
                        : AppColors.grayColor,
                  )),
            ],
          ),
        ),
      ),
      const SizedBox(width: AppDimens.spacingNormal),
      InkWell(
        onTap: () {
          Get.dialog(AlertDialog(
            title: Text(
              S.of(context).doYouReallyWantToDelete,
              style: AppTextStyle.color3C3A36S16W500,
            ),
            content: Text(
              S.of(context).thePointsWillReturnToTheValue0PleaseConfirm,
              style: AppTextStyle.color3C3A36S16,
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    S.of(context).common_cancel,
                    style: AppTextStyle.colorPrimaryS16,
                  )),
              FlatButton(
                  onPressed: () {
                    Get.back();
                    logic.deleteScore(index, () {});
                  },
                  child: Text(
                    'OK',
                    style: AppTextStyle.colorPrimaryS16,
                  ))
            ],
          ));
        },
        child: Container(
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
              Text(S.of(context).remove, style: AppTextStyle.colorGrayS14W500),
            ],
          ),
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
            return _buildScoreItemWidget(index);
          },
          itemCount: state.listScoreEntity.length,
        );
      }),
    );
  }

  Widget _buildScoreItemWidget(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingNormal),
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
              // children: state.viewType.value == ScoreViewType.all
              //     ? [
              //         _buildInfoStudentWidget(
              //             'Code:',
              //             state.listScoreEntity[index].personResponse
              //                     ?.idClass ??
              //                 '',
              //             false),
              //         _buildInfoStudentWidget(
              //             'Birthday:',
              //             state.listScoreEntity[index].personResponse
              //                     ?.birthday ??
              //                 '',
              //             false),
              //         _buildInfoStudentWidget(
              //             'TBTL Hệ 10 N1:', '10', true),
              //         _buildInfoStudentWidget(
              //             'TBTL Hệ4 N1:', '10', true),
              //         _buildInfoStudentWidget(
              //             'Số TCTL N1:', '10', true),
              //         _buildInfoStudentWidget('Số TC N1:', '10', true),
              //       ]
              //     : [
              //         _buildInfoStudentWidget(
              //             'Code:',
              //             state.listScoreEntity[index].personResponse
              //                     ?.idClass ??
              //                 '',
              //             false),
              //         _buildInfoStudentWidget(
              //             'Birthday:',
              //             state.listScoreEntity[index].personResponse
              //                     ?.birthday ??
              //                 '',
              //             false),
              //         _buildInfoStudentWidget('CC:', '10', true),
              //         _buildInfoStudentWidget('KT:', '10', true),
              //         _buildInfoStudentWidget('THI:', '10', true),
              //         _buildInfoStudentWidget('KTHP:', '10', true),
              //         _buildInfoStudentWidget('Chữ:', 'A', true),
              //         _buildInfoStudentWidget('Đánh giá:', 'Đạt', true),
              //       ],
              children: [
                _buildInfoStudentWidget(
                    'Code:',
                    state.listScoreEntity[index].personResponse?.idClass ?? '',
                    false),
                _buildInfoStudentWidget(
                    'Birthday:',
                    state.listScoreEntity[index].personResponse?.birthday ?? '',
                    false),
                _buildInfoStudentWidget(
                  'CC:',
                  '${state.listScoreEntity[index].diligenceTextController?.text}',
                  (authService.person.value?.type == PersonType.GV.name &&
                      (state.listScoreEntity[index].isEdit ?? false)),
                  controller:
                      state.listScoreEntity[index].diligenceTextController,
                  textInputType: TextInputType.number,
                ),
                _buildInfoStudentWidget(
                  'KT:',
                  '${state.listScoreEntity[index].testTextController?.text}',
                  (authService.person.value?.type == PersonType.GV.name &&
                      (state.listScoreEntity[index].isEdit ?? false)),
                  controller: state.listScoreEntity[index].testTextController,
                  textInputType: TextInputType.number,
                ),
                _buildInfoStudentWidget(
                  'THI:',
                  '${state.listScoreEntity[index].examTextController?.text}',
                  (authService.person.value?.type == PersonType.GV.name &&
                      (state.listScoreEntity[index].isEdit ?? false)),
                  controller: state.listScoreEntity[index].examTextController,
                  textInputType: TextInputType.number,
                ),
                _buildInfoStudentWidget(
                  'KTHP:',
                  '${state.listScoreEntity[index].endOfCourseTextController?.text}',
                  (authService.person.value?.type == PersonType.GV.name &&
                      (state.listScoreEntity[index].isEdit ?? false)),
                  controller:
                      state.listScoreEntity[index].endOfCourseTextController,
                  textInputType: TextInputType.number,
                ),
                _buildInfoStudentWidget(
                  'Chữ:',
                  '${state.listScoreEntity[index].letterTextController?.text}',
                  (authService.person.value?.type == PersonType.GV.name &&
                      (state.listScoreEntity[index].isEdit ?? false)),
                  controller: state.listScoreEntity[index].letterTextController,
                ),
                _buildInfoStudentWidget(
                  'Đánh giá:',
                  '${state.listScoreEntity[index].evaluateTextController?.text}',
                  (authService.person.value?.type == PersonType.GV.name &&
                      (state.listScoreEntity[index].isEdit ?? false)),
                  controller:
                      state.listScoreEntity[index].evaluateTextController,
                ),
              ],
            ),
            SizedBox(
              height: authService.person.value?.type == PersonType.GV.name
                  ? AppDimens.spacingNormal
                  : 0,
            ),
            Visibility(
              visible: authService.person.value?.type == PersonType.GV.name,
              child: _buildActionInfoStudentWidget(index),
            ),
            SizedBox(
              height: authService.person.value?.type == PersonType.GV.name
                  ? AppDimens.spacingNormal
                  : 0,
            ),
          ],
          title: Text(
            '#${index + 1}. ${state.listScoreEntity[index].personResponse?.name}',
            style: AppTextStyle.color3C3A36S18W500,
          ),
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
          Obx(
            () => Text(
              "${S.of(context).common_score}(${state.listScoreEntity.length}/${widget.students.length})",
              style: AppTextStyle.colorDarkS24W500,
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                _showDialogInfo();
              },
              icon: const Icon(
                Icons.info_outline,
                color: AppColors.grayColor,
              )),
          const SizedBox(width: AppDimens.spacingNormal),
        ],
      ),
    );
  }

  void _showDialogInfo() {
    logic.checkScoreStudent();
    Get.dialog(AlertDialog(
      title: Text(
        S.of(context).detailInfo,
        style: AppTextStyle.color3C3A36S18W500,
      ),
      content: SizedBox(
        width: 300,
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(4),
            1: FlexColumnWidth(6),
          },
          border: const TableBorder(
            horizontalInside: BorderSide(
              width: 1,
              color: AppColors.grayColor,
              style: BorderStyle.solid,
            ),
            verticalInside: BorderSide(
              width: 1,
              color: AppColors.grayColor,
              style: BorderStyle.solid,
            ),
            top: BorderSide(
              color: AppColors.grayColor,
            ),
            left: BorderSide(
              color: AppColors.grayColor,
            ),
            right: BorderSide(
              color: AppColors.grayColor,
            ),
            bottom: BorderSide(
              color: AppColors.grayColor,
            ),
          ),
          children: [
            _buildRowTableWidget(S.of(context).common_subject,'${widget.subjectResponse.name}'),
            _buildRowTableWidget(S.of(context).common_code,'${widget.subjectResponse.code}'),
            _buildRowTableWidget('Sinh viên đăng ký học','${state.listScoreEntity.length}'),
            _buildRowTableWidget('Sinh viên không đăng ký học','${widget.students.length}'),
            _buildRowTableWidget('Sinh viên đã có điểm','${state.countScore}'),
            _buildRowTableWidget('Sinh viên chưa có điểm','${state.countNotScore}'),
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            S.of(context).common_ok,
            style: AppTextStyle.color3C3A36S18W500.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        )
      ],
    ));
  }

  TableRow _buildRowTableWidget(String title,String value){
    return TableRow(children: [
      Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10,left: 10),
        child: Text(
          title,
          style: AppTextStyle.colorDarkS16W500,
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
        child: Text(
          value,
          style: AppTextStyle.colorDarkS16W500,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  }

}
