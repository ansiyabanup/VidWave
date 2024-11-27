import 'package:get/get.dart';
import 'package:video_editor_app/app/modules/videopick/controllers/videopick_controller.dart';

class VideopickBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PickVideoController>(
      () => PickVideoController(),
    );
  }
}
