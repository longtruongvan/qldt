import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/model/response/building_response.dart';
import 'package:qldt/model/response/department_response.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/detail_department/detail_department_state.dart';

import '../../../../common/app_colors.dart';

class DetailDepartmentLogic extends GetxController{
  final state = DetailDepartmentState();

  DetailDepartmentLogic() {}

  void fetchData({
    required DepartmentResponse departmentResponse,
    required BuildingResponse buildingResponse,
    required List<BuildingResponse> listBuildingResponse,
    required Function() callback,
  }) {
    state.departmentResponse.value = departmentResponse;
    state.buildingResponse.value = buildingResponse;
    state.listBuildingResponse.clear();
    state.listBuildingResponse.addAll(listBuildingResponse);

    state.statusLoading.value = true;
    FirebaseFirestore.instance
        .collection('Department')
        .doc(departmentResponse.id)
        .snapshots()
        .listen((dataSnapshot) {
      if (dataSnapshot.data() != null) {
        var dataDepartment = DepartmentResponse.fromJson(dataSnapshot.data()!);
        var dataBuilding = state.buildingResponse.value;
        // update ui while update department
        for (int i = 0; i < state.listBuildingResponse.length; i++) {
          if (state.listBuildingResponse[i].id == dataDepartment.idBuilding) {
            dataDepartment.nameBuilding = state.listBuildingResponse[i].name;
          }
        }
        state.departmentResponse.value = dataDepartment;
        state.buildingResponse.value = dataBuilding;
        state.nameBuilding.value = dataBuilding.name ?? '';
        state.departmentResponse.refresh();
        state.buildingResponse.refresh();
        // update ui while update department
      } else {}
      state.statusLoading.value = false;
    }).onError((error) {
      state.statusLoading.value = false;
      Get.snackbar(
        'Error',
        'Fetch data failure',
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
      );
    });

    FirebaseFirestore.instance
        .collection('Building')
        .doc(buildingResponse.id)
        .snapshots()
        .listen((dataSnapshot) {
      if (dataSnapshot.data() != null) {
        state.buildingResponse.value =
            BuildingResponse.fromJson(dataSnapshot.data()!);
        state.nameBuilding.value = state.buildingResponse.value.name ?? '';
      } else {}
      state.statusLoading.value = false;
    }).onError((error) {
      state.statusLoading.value = false;
      Get.snackbar(
        'Error',
        'Fetch data failure',
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
      );
    });
  }

  void deleteClassroom({required String id,required Function() callback}) {
    Get.back();
    state.statusLoading.value = true;
    FirebaseFirestore.instance
        .collection('Department')
        .doc(id)
        .delete()
        .then((value) {
      state.statusLoading.value = false;
      Get.back(closeOverlays: true);
      Get.snackbar(
        'Success',
        'Delete department success',
        backgroundColor: AppColors.successColor,
        colorText: AppColors.whiteColor,
      );
    }).catchError((onError) {
      state.statusLoading.value = false;
      Get.snackbar(
        'Error',
        'Delete department failure',
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
      );
    });
  }

  void bookClassroomHandler({required String id,required Function() callback}) {
    state.statusLoading.value = true;
    FirebaseFirestore.instance.collection('Department').doc(id).update({
      'status': !(state.departmentResponse.value.status ?? false)
    }).then((value) {
      Get.snackbar(
        'Success',
        'Book class room success',
        backgroundColor: AppColors.successColor,
        colorText: AppColors.whiteColor,
      );
      state.statusLoading.value = false;
    }).catchError((onError) {
      Get.snackbar(
        'Error',
        'Book class room failure',
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
      );
      state.statusLoading.value = false;
    });
  }
}
