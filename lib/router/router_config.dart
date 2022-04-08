import 'package:get/get.dart';
import 'package:qldt/ui/main/main_page.dart';

import '../ui/splash/splash_page.dart';

class RouterConfig {
  static String splash = '/splash';
  static String main = '/main';

  static final List<GetPage> getPages = [
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: main, page: () => const MainPage()),
  ];
}
