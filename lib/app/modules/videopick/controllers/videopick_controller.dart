// lib/app/modules/pick_video/controllers/pick_video_controller.dart
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class PickVideoController extends GetxController {
  final selectedVideos = <String>[].obs;
  final isLoading = false.obs;

  Future<void> pickVideos() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: true,
    );

    if (result != null) {
      isLoading.value = true;
      selectedVideos.assignAll(result.paths.whereType<String>());
      await Future.delayed(Duration(seconds: 1));
      isLoading.value = false;
      Get.toNamed('/editing', arguments: selectedVideos);
      update();
    }
  }
}



