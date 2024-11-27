
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class EditingController extends GetxController {
  final videos = <String>[].obs; 
  final selectedVideoIndex = 0.obs;
  final selectedVideoPlayer = Rx<VideoPlayerController?>(null);

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as List<String>;
    videos.assignAll(args);

    
    if (videos.isNotEmpty) {
      playVideo(0);
    }
  }

  void playVideo(int index) {
    selectedVideoPlayer.value?.dispose(); 
    final newController = VideoPlayerController.file(File(videos[index]));
    selectedVideoPlayer.value = newController;
    selectedVideoIndex.value = index;

    newController.initialize().then((_) {
      newController.play();
      update();
    });
  }

  // Future<void> trimVideo() async {
  //   final inputPath = videos[selectedVideoIndex.value];
  //   final outputPath = '${inputPath}_trimmed.mp4';
  //   final start = 0.0; // Start trimming from the beginning
  //   final duration = selectedVideoPlayer.value!.value.duration.inSeconds.toDouble();

  //   final command = '-i $inputPath -ss $start -t $duration -c copy $outputPath';
  //   await FFmpegKit.execute(command).then((session) async {
  //     final returnCode = await session.getReturnCode();
  //     if (returnCode?.isValueSuccess() ?? false) {
  //       Get.snackbar('Trim Success', 'Video trimmed successfully!');
  //     } else {
  //       Get.snackbar('Error', 'Failed to trim the video.');
  //     }
  //   });
  // }

  @override
  void onClose() {
    selectedVideoPlayer.value?.dispose();
    super.onClose();
  }
}
