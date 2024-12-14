import 'dart:io';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class EditingController extends GetxController {
  final videos = <String>[].obs; // List of video paths
  final videoControllers =
      <VideoPlayerController>[].obs; // Controllers for each video
  final selectedVideoIndex = 0.obs; // Current video index
  final isPlaying = false.obs;
  final isPlaybackCompleted = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as List<String>;
    videos.assignAll(args);
    print(
        'Received videos in order: ${videos.join(", ")}'); // Log received order
    loadAllVideos();
  }

  Future<void> loadAllVideos() async {
// Ensure all controllers are initialized in order
    //videoControllers.clear();

    for (int i = 0; i < videos.length; i++) {
      final controller = VideoPlayerController.file(File(videos[i]));
      await controller.initialize().then((_) {
        controller.addListener(() {
          if (controller.value.position >= controller.value.duration) {
            if (i == videos.length - 1) {
              stopPlayback();
            } else {
              playNextVideo();
            }
          }
        });
        videoControllers.add(controller);
        print('Video loaded: ${videos[i]}'); // Log each video as it's loaded

        if (i == 0) selectedVideoIndex.value = 0;

        update();
      }).catchError((e) {
        print('Error loading video: ${videos[i]}, Error: $e');
      });
    }
  }

  //   void updateFrameOffset() {
  //   // Adjust frame offset based on the current video's playback progress
  //   final currentController = videoControllers[selectedVideoIndex.value];
  //   final progress = currentController.value.position.inMilliseconds /
  //       currentController.value.duration.inMilliseconds;
  //   frameOffset.value = progress;
  // }

  void playPauseToggle() {
    if (isPlaybackCompleted.value) {
      restartPlayback();
    } else {
      final currentController = videoControllers[selectedVideoIndex.value];
      if (isPlaying.value) {
        currentController.pause();
      } else {
        currentController.play();
      }
      isPlaying.value = !isPlaying.value;
    }
  }

  void playNextVideo() {
    final currentIndex = selectedVideoIndex.value;
    videoControllers[currentIndex].pause();
    videoControllers[currentIndex].seekTo(Duration.zero);

    // if(currentIndex + 1 >= videoControllers.length){
    //   // Stop playback after the last video
    //   isPlaying.value = false;
    //   return;
    // }

    final nextIndex = (currentIndex + 1) % videoControllers.length;
    selectedVideoIndex.value = nextIndex;

    videoControllers[nextIndex].play();
    isPlaying.value = true;
  }

  void stopPlayback() {
    final currentIndex = selectedVideoIndex.value;
    videoControllers[currentIndex].pause();
    videoControllers[currentIndex].seekTo(Duration.zero);

    isPlaybackCompleted.value = true;
    isPlaying.value = false;
  }

  void restartPlayback() {
    isPlaybackCompleted.value = false;
    selectedVideoIndex.value = 0;
    videoControllers[0].play();

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
