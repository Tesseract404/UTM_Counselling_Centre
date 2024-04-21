import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Screens/Dashboard.dart';
import 'package:utm_counselling_centre/Screens/Login.dart';
import 'package:utm_counselling_centre/Screens/Quiz.dart';
import 'package:utm_counselling_centre/Screens/Register.dart';

import 'Screens/LandingPage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "UTM Counselling",
      routes: {
        '/': (context) => const LandingPage(),
        '/register': (context) => const Register(),
        '/login': (context) => const Login(),
        '/dash': (context) => const Dashboard(),
        '/quiz': (context) => const Quiz(),
      },
      initialRoute: '/',
    ),
  );
}
