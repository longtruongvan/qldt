import 'package:get/get.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/system_manager_department_manager_page.dart';

class SystemManagerHomeLogic {
  void goToDepartmentManager() {
    Get.to(const SystemManagerDepartmentManagerPage());
  }
}
