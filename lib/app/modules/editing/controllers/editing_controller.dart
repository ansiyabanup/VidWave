import 'dart:io';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class EditingController extends GetxController {
  final videos = <String>[].obs; // List of video paths
  final videoControllers =
      <VideoPlayerController>[].obs; // Controllers for each video
  final selectedVideoIndex = 0.obs; // Current video index
  final isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as List<String>;
    videos.assignAll(args);
    loadAllVideos();
  }

  void loadAllVideos() {
    for (int i = 0; i < videos.length; i++) {
      final controller = VideoPlayerController.file(File(videos[i]));
      controller.initialize().then((_) {
        controller.addListener(() {
          if (controller.value.position >= controller.value.duration) {
            playNextVideo();
          }
        });
        videoControllers.add(controller);
        update();
      });
    }
  }

  void playPauseToggle() {
    final currentController = videoControllers[selectedVideoIndex.value];
    if (isPlaying.value) {
      currentController.pause();
    } else {
      currentController.play();
    }
    isPlaying.value = !isPlaying.value;
  }

  void playNextVideo() {
    final currentIndex = selectedVideoIndex.value;
    videoControllers[currentIndex].pause();
    videoControllers[currentIndex].seekTo(Duration.zero);

    final nextIndex = (currentIndex + 1) % videoControllers.length;
    selectedVideoIndex.value = nextIndex;

    videoControllers[nextIndex].play();
    isPlaying.value = true;
  }

  void selectVideo(int index) {
    final currentIndex = selectedVideoIndex.value;
    videoControllers[currentIndex].pause();
    videoControllers[currentIndex].seekTo(Duration.zero);

    selectedVideoIndex.value = index;
    videoControllers[index].play();
    isPlaying.value = true;
  }

  void jumpToFrame(int index, double progress) {
    final videoController = videoControllers[index];
    final position = videoController.value.duration * progress;
    videoController.seekTo(position);
  }

  @override
  void onClose() {
    for (var controller in videoControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
