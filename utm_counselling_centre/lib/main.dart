import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/AdminScreens/AdminDashboard.dart';
import 'package:utm_counselling_centre/AdminScreens/AdminFeed.dart';
import 'package:utm_counselling_centre/AdminScreens/AdminLogin.dart';
import 'package:utm_counselling_centre/AdminScreens/AdminManageSchedule.dart';
import 'package:utm_counselling_centre/AdminScreens/AdminPatientReports.dart';
import 'package:utm_counselling_centre/Screens/Dashboard.dart';
import 'package:utm_counselling_centre/Screens/FeedBack.dart';
import 'package:utm_counselling_centre/Screens/Login.dart';
import 'package:utm_counselling_centre/Screens/Quiz.dart';
import 'package:utm_counselling_centre/Screens/Register.dart';
import 'package:utm_counselling_centre/Screens/Results.dart';

import 'AdminScreens/Cnotification.dart';
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
        '/results': (context) => const Results(),
        '/feed': (context) =>  const  FeedBack(),
        '/adminLogin': (context) =>  const AdminLogin(),
        '/admindash': (context) =>    const AdminDashboard(counsellor: true,),
        '/adminmanage': (context) => const  AdminManageSchedule(counsellor: true,),
        '/adminpatient': (context) =>  const AdminPatientReports(),
        '/notification': (context) =>  const Cnotification(),
        '/adminfeed': (context) =>  const AdminFeed(),
      },
      initialRoute: '/',
    ),
  );
}
