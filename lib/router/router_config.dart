import 'package:get/get.dart';
import 'package:qldt/ui/main/main_page.dart';
import 'package:qldt/ui/system_manager/main/system_manager_main_page.dart';

import '../ui/splash/splash_page.dart';

class RouterConfig {
  static String splash = '/splash';
  static String main = '/main';
  static String systemManagerMain = '/system_manager_main';

  static final List<GetPage> getPages = [
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: main, page: () => const MainPage()),
    GetPage(name: systemManagerMain, page: () => const SystemManagerMainPage()),
  ];
}
