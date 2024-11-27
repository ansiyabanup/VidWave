import 'package:get/get.dart';

import '../controllers/editing_controller.dart';

class EditingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditingController>(
      () => EditingController(),
    );
  }
}
