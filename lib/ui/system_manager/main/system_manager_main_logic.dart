import 'package:qldt/ui/system_manager/main/system_manager_main_state.dart';

class SystemManagerMainLogic {
  final state = SystemManagerMainState();

  void switchTab() {
    state.pageController.jumpToPage(state.itemSelected.value);
  }
}
