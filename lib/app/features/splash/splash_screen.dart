import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/features/splash/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21), // elegant dark theme
      body: Stack(
        children: [

          // Center content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // App Logo
                Image.asset(
                  'assets/icons/windspeed.png',
                  height: 120,
                  width: 120,
                ),
                const SizedBox(height: 20),

                // App Name
                const Text(
                  "Weather App",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.3,
                  ),
                ),

                const SizedBox(height: 10),

                // Subtitle
                const Text(
                  "Your daily weather companion",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
