import 'package:get/get.dart';

import '../controllers/videopick_controller.dart';

class VideopickBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideopickController>(
      () => VideopickController(),
    );
  }
}
