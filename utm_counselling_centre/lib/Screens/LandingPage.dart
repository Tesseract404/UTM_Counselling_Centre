import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'package:utm_counselling_centre/Widgets/Buttons/RegularButton.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFC094F8), Colors.white],
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      height: 100,
                      width: 100,
                      image: AssetImage('assets/logo.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'UTM Counselling',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: GoogleFonts.oswald().fontFamily,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryColor
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Mental health is crucial for overall well-being, affecting how we think, feel, and act. UTM Counselling emphasizes this by providing access to professional counsellors, ensuring individuals receive timely support and guidance. Prioritizing mental health enhances quality of life, productivity, and relationships, fostering resilience and emotional balance in today’s fast-paced world.',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.secondaryTextColor
                          //fontFamily: GoogleFonts.oswald().fontFamily,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Image(image: AssetImage('assets/info.png',),height: 250,width: 300,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: RegularButton(title: 'Get Started', route: '/login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
