import 'package:get/get.dart';
import 'package:qldt/ui/teacher/teacher_profile/teacher_profile_state.dart';

import '../../../services/auth_service.dart';

class TeacherProfileLogic extends GetxController{
  final state = TeacherProfileState();
  final authService = Get.find<AuthService>();

  TeacherProfileLogic(){
    state.phoneTextController.text = authService.person.value?.phone ?? '';
    state.locationTextController.text =
        authService.person.value?.location ?? '';
  }
}