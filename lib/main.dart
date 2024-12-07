import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_editor_app/app/modules/videopick/controllers/videopick_controller.dart';
import 'package:video_editor_app/app/modules/videopick/views/videopick_view.dart';
import 'app/routes/app_pages.dart';

// void main() {
//   runApp(
//     GetMaterialApp(
//       title: "Application",
//       initialRoute: AppPages.INITIAL,
//       getPages: AppPages.routes,
//     ),
//   );
// }

// class AppBindings extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<PickVideoController>(() => PickVideoController());
//   }
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black, // Set global background color
      ),
    );
  }
}
