import 'package:get/get.dart';
import 'package:world_time/view/screens/home_screen.dart';
import '../model/bnScreen.dart';
import '../view/screens/list_screen.dart';
import '../view/screens/settings_screen.dart';

class BnController extends GetxController {
  RxInt currentIndex = 0.obs;

  final List<BnScreenModel> screens = <BnScreenModel>[
    BnScreenModel(widget: const HomeScreen(), title: 'CLOCK'),
    BnScreenModel(widget: const ListScreen(), title: 'LIST'),
    BnScreenModel(widget: const SettingsScreen(), title: 'SETTINGS'),
  ];
}
