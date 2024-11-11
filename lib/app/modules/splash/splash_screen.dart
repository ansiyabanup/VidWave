import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 25, 25), // Background black color
      body: Stack(
        children: [
        
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/splash_image.png',
                      width: media.width,
                      fit: BoxFit.cover,
                    ),
                    // Gradient overlay to blend the image into black
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                            colors: [
                              const Color.fromARGB(255, 27, 25, 25), // Black at the bottom
                              Colors.transparent, // Transparent towards the center
                            ],
                            stops: [0.7, 0.9], // Adjust stops for smooth blending
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Bottom 
              Expanded(
                flex: 1,
                child: Container(
                  color: const Color.fromARGB(255, 27, 25, 25), // Solid black color
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/videopick');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        ),
                        child: const Text("Get Started"),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                         
                        },
                        child: const Text(
                          "Privacy Policy",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

