import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideopickController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  //List<XFile>? _selectedFiles;

  //from videoplyr package
  VideoPlayerController? videoController;
  // bool _isVideo = false;


  Future<void> pickVideo() async {
    try {
      final XFile? videoFile =
          await _picker.pickVideo(source: ImageSource.gallery);
      if (videoFile != null) {
        videoController = VideoPlayerController.file(File(videoFile.path))
          ..initialize().then((_) {
               update();
            videoController?.play();
           // update();
          });
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed in picking the video: $e');
    }
  }

  
  @override
  void onClose() {
    videoController?.dispose();
    super.onClose();
  }
}
