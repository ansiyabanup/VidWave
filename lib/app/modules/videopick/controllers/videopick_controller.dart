import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class PickVideoController extends GetxController {
  final selectedVideos = <String>[].obs;
  final isLoading = false.obs;
  // bool hasNavigated = false;

  Future<void> pickVideos() async {
    isLoading.value = true;
    final result = await FilePicker.platform.pickFiles(
        type: FileType.video, allowMultiple: true, allowCompression: false);

    if (result != null) {
      //isLoading.value = true;
      selectedVideos.assignAll(result.paths.whereType<String>());
      print(
          'Selected videos in order: ${selectedVideos.join(", ")}'); // Log selected order
      await Future.delayed(const Duration(seconds: 1));

      Get.toNamed('/editing', arguments: selectedVideos.toList());
      isLoading.value = false;
      update();
    }
  }
}
