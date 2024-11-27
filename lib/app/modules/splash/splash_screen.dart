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
      backgroundColor:
          const Color.fromARGB(255, 27, 25, 25), // Background black color
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 10,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/splash_image.png',
                      width: media.width,
                      fit: BoxFit.cover,
                    ),

// Positioned text 

                  
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                            colors: [
                              const Color.fromARGB(
                                  255, 20, 20, 20), // Black at the bottom
                              const Color.fromARGB(0, 230, 207,
                                  207), // Transparent towards the center
                            ],
                            stops: [
                              0.9,
                              0.9
                            ], // Adjust stops for smooth blending
                          ),
                        ),

                        //till this
                      ),
                    ),

                    Positioned.fill(
                        child: Align(
                      alignment: Alignment(0.0, 0.5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              backgroundColor: const Color.fromARGB(255, 225, 225, 236), // Custom button color
                            ),
                            child: const Text("Get Started"),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              // Free trial action
                            },
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed('/videopick');
                                
                              },
                              child: const Text(
                                "Enable free trial",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
