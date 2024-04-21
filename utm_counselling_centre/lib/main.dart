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
import 'package:utm_counselling_centre/Screens/Reports.dart';
import 'package:utm_counselling_centre/Screens/Results.dart';
import 'package:utm_counselling_centre/Screens/SplashScreen.dart';
import 'AdminScreens/Cnotification.dart';
import 'Constants/AppContext.dart';
import 'Screens/LandingPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/Schedules.dart';
import 'firebase_options.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      navigatorKey: AppContext.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: "UTM Counselling",
      routes: {
        '/': (context) => const SplashScreen(),
        '/land': (context) => const LandingPage(),
        '/register': (context) => const Register(),
        '/login': (context) => const Login(),
        '/dash': (context) => const Dashboard(),
        '/quiz': (context) => const Quiz(),
        '/results': (context) => const Results(done: false,),
        '/feed': (context) => const  FeedBack(),
        '/report': (context) => const  Reports(),
        '/schedule': (context) => const  Schedules(),
        '/adminLogin': (context) => const AdminLogin(),
        '/admindash': (context) => const AdminDashboard(counsellor: true,),
        '/adminmanage': (context) => const  AdminManageSchedule(counsellor: true,),
        '/adminpatient': (context) =>  const AdminPatientReports(counsellor: true,),
        '/notification': (context) =>  const Cnotification(),
        '/adminfeed': (context) =>  const AdminFeed(),
      },
      initialRoute: '/',
    ),
  );
}
