import 'package:get/get.dart';
import 'package:qldt/ui/system_manager/specialized/add_specialized/add_specialized_state.dart';

class AddSpecializedLogic extends GetxController {
  final state = AddSpecializedState();

  void submitButtonClickListener() {
    if (state.nameTextController.text == '' ||
        state.displayNameTextController.text == '') {

      return;
    }
  }
}
