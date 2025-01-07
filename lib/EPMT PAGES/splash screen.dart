import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled42/EPMT%20PAGES/sing%20in%20page.dart';

class SurgSplash extends StatefulWidget {
  const SurgSplash({super.key});

  @override
  State<SurgSplash> createState() => _SurgSplashState();
}

class _SurgSplashState extends State<SurgSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/image/spl.jpg",
              fit: BoxFit.cover, // Adjust to fill the screen
            ),
          ),
          // Overlay for Logo and Text
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white.withOpacity(0.8),
                  child: Image.asset(
                    "assets/image/lll.jpg", // Replace with your logo path
                    height: 80,
                  ),
                ),
                SizedBox(height: 20),
                // Text
                Text(
                  "EQUIPMED",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(height: 30),
                // Get Started Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text(
                    "GET STARTED",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
