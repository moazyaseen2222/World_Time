import 'package:get/get.dart';
import 'package:world_time/constant/routes_name.dart';
import 'package:world_time/view/screens/bn_screen.dart';

import '../view/screens/ascending_counter_screen.dart';
import '../view/screens/count_down_screen.dart';
import '../view/screens/home_screen.dart';
import '../view/screens/list_screen.dart';
import '../view/screens/settings_screen.dart';
import '../view/screens/splash_screen.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
            name: RoutesName.splashScreen, page: () => const SpalshScreen()),
        GetPage(
          name: RoutesName.homeScreen,
          page: () => const HomeScreen(),
          transition: Transition.downToUp,
        ),
        GetPage(name: RoutesName.bnScreen, page: () => const BnScreen()),
        GetPage(name: RoutesName.listScreen, page: () => const ListScreen()),
        GetPage(
            name: RoutesName.settingsScreen,
            page: () => const SettingsScreen()),
        GetPage(
            name: RoutesName.ascendingCounterScreen,
            page: () => const AscendingCounterScreen()),
        GetPage(
            name: RoutesName.countDownScreen,
            page: () => const CountDownScreen()),
      ];
}
