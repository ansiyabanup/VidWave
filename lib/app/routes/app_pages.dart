import 'package:get/get.dart';
import 'package:video_editor_app/app/modules/editing/bindings/editing_binding.dart';
import 'package:video_editor_app/app/modules/editing/views/editing_view.dart';
import 'package:video_editor_app/app/modules/videopick/bindings/videopick_binding.dart';
import '../modules/gallery/bindings/gallery_binding.dart';
import '../modules/gallery/views/gallery_view.dart';
import '../modules/permisssion/bindings/permission_binding.dart';
import '../modules/permisssion/views/permission_view.dart';
import '../modules/splash/splash_screen.dart';

import '../modules/videopick/views/videopick_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.PERMISSION,
      page: () => const PermissionView(),
      binding: PermissionBinding(),
    ),
    GetPage(
      name: _Paths.VIDEOPICK,
      page: () => PickVideoView(),
      binding: VideopickBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: _Paths.EDITING,
      page: () => EditingView(),
      binding: EditingBinding(),
    ),
    GetPage(
      name: _Paths.GALLERY,
      page: () => const GalleryView(),
      binding: GalleryBinding(),
    ),
  ];
}
