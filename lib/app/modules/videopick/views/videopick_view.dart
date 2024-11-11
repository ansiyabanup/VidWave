import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../controllers/videopick_controller.dart';

class VideopickView extends GetView<VideopickController> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Media Picker')),
      body: Center(
        child: GetBuilder<VideopickController>(
          builder: (controller) {
            if (controller.videoController != null && controller.videoController!.value.isInitialized) {
              return AspectRatio(
                aspectRatio: controller.videoController!.value.aspectRatio,
                
                child: VideoPlayer(controller.videoController!),
              );
            } else {
              return const Text("No video selected");
            }
          },
        ),
      ),
      floatingActionButton: 
     
      
          FloatingActionButton(
            onPressed:  controller.pickVideo,
            tooltip: 'Pick Video',
            child: const Icon(Icons.video_library),
          ),
     
    );
  }
}


// class VideoGalleryView extends GetView<VideoGalleryController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Select Videos")),
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(() => GridView.builder(
//                   itemCount: controller.videoList.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,
//                   ),
//                   itemBuilder: (context, index) {
//                     final video = controller.videoList[index];
//                     return GestureDetector(
//                       onTap: () {
//                         controller.toggleSelection(video);
//                       },
//                       child: Stack(
//                         children: [
//                           // Thumbnail here (using a placeholder)
//                           Container(color: Colors.black38),
//                           if (controller.isSelected(video))
//                             Positioned(
//                               top: 0,
//                               right: 0,
//                               child: Icon(Icons.check_circle, color: Colors.green),
//                             ),
//                         ],
//                       ),
//                     );
//                   },
//                 )),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 if (controller.selectedVideos.isNotEmpty) {
//                   Get.toNamed('/video_player', arguments: controller.selectedVideos);
//                 } else {
//                   Get.snackbar("Selection Error", "Please select at least one video");
//                 }
//               },
//               child: Text("Next"),
//               style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }