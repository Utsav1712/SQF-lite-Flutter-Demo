import 'package:get/get.dart';

import '../modules/add_user_screen/bindings/add_user_screen_binding.dart';
import '../modules/add_user_screen/bindings/add_user_screen_binding.dart';
import '../modules/add_user_screen/views/add_user_screen_view.dart';
import '../modules/add_user_screen/views/add_user_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => const HomeView(),
        binding: HomeBinding(),
        transition: Transition.fade),
    GetPage(
        name: _Paths.ADD_USER_SCREEN,
        page: () => const AddUserScreenView(),
        binding: AddUserScreenBinding(),
        transition: Transition.fade),
  ];
}
