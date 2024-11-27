// lib/app/modules/pick_video/views/pick_video_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_editor_app/app/modules/videopick/controllers/videopick_controller.dart';

class PickVideoView extends GetView<PickVideoController> {
  const PickVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    final PickVideoController controller = Get.find<PickVideoController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Editor'),
      ),
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const CircularProgressIndicator();
          }
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.pickVideos,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                backgroundColor: const Color.fromARGB(255, 165, 164, 208),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'New Project',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }),
      ),
    );
  }
}
