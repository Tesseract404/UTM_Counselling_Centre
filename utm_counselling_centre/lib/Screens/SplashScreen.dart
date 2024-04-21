import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();

    // Delay the fade-out and navigate to the next screen after 3 seconds
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _opacity = 0.0; // Start the fade-out
      });

      // Navigate to the main screen after the fade-out duration
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, '/land');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(seconds: 1), // Fade-out duration
        child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.tertiaryColor, Color(0xff451087)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
            child: Image.asset('assets/AppIcon.png', height: 100), // Replace with your logo asset
          ),
        ),
      ),
    );
  }
}
