import 'package:get/get.dart';
import 'package:video_editor_app/app/modules/splash/splash_screen.dart';
import 'package:video_editor_app/app/modules/videopick/bindings/videopick_binding.dart';
import 'package:video_editor_app/app/modules/videopick/views/videopick_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/permisssion/bindings/permission_binding.dart';
import '../modules/permisssion/views/permission_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PERMISSION,
      page: () => const PermissionView(),
      binding: PermissionBinding(),
    ),
    GetPage(
      name: _Paths.VIDEOPICK,
      page: () => VideopickView(),
      binding: VideopickBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
    ),
  ];
}
