import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_editor_app/app/modules/editing/controllers/editing_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail_slider/video_thumbnail_slider.dart';

class EditingView extends GetView<EditingController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditingController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Editor'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final selectedIndex = controller.selectedVideoIndex.value;
              if (controller.videoControllers.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              final videoPlayerController =
                  controller.videoControllers[selectedIndex];

              return Stack(
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(videoPlayerController),
                    ),
                  ),
                ],
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Obx(() {
              return ElevatedButton(
                onPressed: controller.playPauseToggle,
                child: Text(controller.isPlaying.value ? 'Pause' : 'Play'),
              );
            }),
          ),
          Obx(() {
            if (controller.videoControllers.isEmpty) {
              return const Center(child: Text('No videos available'));
            }

            return SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.videos.length,
                itemBuilder: (context, index) {
                  final videoController = controller.videoControllers[index];
                  final isSelected =
                      controller.selectedVideoIndex.value == index;
                  // final videoPath = controller.videos[index];

                  return Column(
                    children: [
                      // Video Frames
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                isSelected ? Colors.purple : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: SizedBox(
                          height: 90,
                          width: 200,
                          child: VideoThumbnailSlider(
                            controller: videoController,
                            // videoPath: videoPath,
                            splitImage: 5,
                            backgroundColor: Colors.black,
                            frameBuilder: (imgData) => Container(
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                              ),
                              child: Image.memory(imgData, fit: BoxFit.cover),
                            ),
                            customCurrentFrameBuilder: (controller) =>
                                GestureDetector(
                              onTap: () {
                                final progress = controller
                                        .value.position.inMilliseconds /
                                    controller.value.duration.inMilliseconds;
                                controller.seekTo(
                                    controller.value.duration * progress);
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.red, width: 2),
                                ),
                                child: VideoPlayer(controller),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Video Selector
                      GestureDetector(
                        onTap: () => controller.selectVideo(index),
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  index == controller.selectedVideoIndex.value
                                      ? Colors.blue
                                      : Colors.transparent,
                            ),
                          ),
                          child: Text(
                            'Video ${index + 1}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}





// class EditingView extends GetView<EditingController> {
//   @override
//   Widget build(BuildContext context) {
//     final EditingController controller = Get.find<EditingController>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Videos'),
//       ),
//       body: Column(
//         children: [
//           // Main video player
//           Expanded(
//             child: Obx(() {
//               if (controller.videoControllers.isEmpty ||
//                   !controller
//                       .videoControllers[controller.selectedVideoIndex.value]
//                       .value
//                       .isInitialized) {
//                 return const Center(
//                   child: Text('Loading video...'),
//                 );
//               }
//               final currentController = controller
//                   .videoControllers[controller.selectedVideoIndex.value];
//               return Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   AspectRatio(
//                     aspectRatio: currentController.value.aspectRatio,
//                     child: VideoPlayer(currentController),
//                   ),
//                   // Static white line in the center
//                   Positioned(
//                     bottom: 20,
//                     child: Container(
//                       width: 2,
//                       height: 50,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               );
//             }),
//           ),

//           // Video frames in a horizontal ListView.builder
//           SizedBox(
//             height: 120,
//             child: Obx(() {
//               return ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: controller.videos.length,
//                 itemBuilder: (context, index) {
//                   final isSelected =
//                       controller.selectedVideoIndex.value == index;

//                   return GestureDetector(
//                     onTap: () => controller.playVideo(index),
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 8.0),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: isSelected ? Colors.brown : Colors.transparent,
//                           width: 3,
//                         ),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: VideoThumbnailSlider(
//                         controller: controller.videoControllers[index],
//                         splitImage: 7, // Number of frames to generate
//                         width: 150,
//                         height: 80,
//                         backgroundColor: Colors.grey[800]!,
//                         frameBuilder: (imgData) => Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Colors.black.withOpacity(0.1),
//                               width: 0.5,
//                             ),
//                           ),
//                           child: Image.memory(
//                             imgData,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         customCurrentFrameBuilder: (_) => Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.brown, width: 2),
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: Icon(Icons.play_arrow, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),

//           // Play/Pause button
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16.0),
//             child: Obx(() {
//               return IconButton(
//                 icon: Icon(
//                   controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
//                   size: 40,
//                 ),
//                 onPressed: controller.togglePlayPause,
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

///////////////////////
// class EditingView extends GetView<EditingController> {
//   const EditingView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Videos'),
//       ),
//       body: Column(
//         children: [

//           Expanded(
//             child: Obx(() {
//               if (controller.selectedVideoPlayer.value == null) {
//                 return const Center(
//                   child: Text('Select a video from the list below'),
//                 );
//               }
//               return AspectRatio(
//                 aspectRatio: controller.selectedVideoPlayer.value!.value.aspectRatio,
//                  child: ClipRRect(
//     borderRadius: BorderRadius.circular(12),
//     child: VideoPlayer(controller.selectedVideoPlayer.value!),
//   ),
//               );
//             }),
//           ),

//           SizedBox(
//             height: 120,
//             child: Obx(() {
//              return ListView.builder(
//   scrollDirection: Axis.horizontal,
//   itemCount: controller.videos.length,
//   itemBuilder: (context, index) {
//     final isSelected = controller.selectedVideoIndex.value == index;

//     return GestureDetector(
//       onTap: () => controller.playVideo(index),
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 8.0),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: isSelected ? Colors.blue : Colors.transparent,
//             width: 3,
//           ),
//           borderRadius: BorderRadius.circular(8),

//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.video_library,
//               size: 50,
//              color:  Colors.grey,
//             ), // Placeholder for thumbnail
//             const SizedBox(height: 8),
//             Text(
//               'Video ${index + 1}',
//               style: TextStyle(
//                 //color: isSelected ? Colors.blue : Colors.white,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   },
// );

//             }),
//           ),

//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             // child: ElevatedButton.icon(
//             //   onPressed: controller.trimVideo,
//             //   icon: const Icon(Icons.edit),
//             //   label: const Text('Trim Video'),
//             // ),

//           ),
//         ],
//       ),
//     );
//   }
// }
