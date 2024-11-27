
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../controllers/editing_controller.dart';

class EditingView extends GetView<EditingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Videos'),
      ),
      body: Column(
        children: [
      
          Expanded(
            child: Obx(() {
              if (controller.selectedVideoPlayer.value == null) {
                return const Center(
                  child: Text('Select a video from the list below'),
                );
              }
              return AspectRatio(
                aspectRatio: controller.selectedVideoPlayer.value!.value.aspectRatio,
                 child: ClipRRect(
    borderRadius: BorderRadius.circular(12), 
    child: VideoPlayer(controller.selectedVideoPlayer.value!),
  ),
              );
            }),
          ),

          
          SizedBox(
            height: 120,
            child: Obx(() {
             return ListView.builder(
  scrollDirection: Axis.horizontal,
  itemCount: controller.videos.length,
  itemBuilder: (context, index) {
    final isSelected = controller.selectedVideoIndex.value == index;

    return GestureDetector(
      onTap: () => controller.playVideo(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(8),
         
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.video_library,
              size: 50,
             color:  Colors.grey,
            ), // Placeholder for thumbnail
            const SizedBox(height: 8),
            Text(
              'Video ${index + 1}',
              style: TextStyle(
                //color: isSelected ? Colors.blue : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  },
);

            }),
          ),

         
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            // child: ElevatedButton.icon(
            //   onPressed: controller.trimVideo,
            //   icon: const Icon(Icons.edit),
            //   label: const Text('Trim Video'),
            // ),

          ),
        ],
      ),
    );
  }
}
