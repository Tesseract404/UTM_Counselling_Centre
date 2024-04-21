import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/AdminScreens/AdminManageSchedule.dart';
import 'package:utm_counselling_centre/AdminScreens/AdminPatientReports.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'package:utm_counselling_centre/Firebase%20Authentication/firebase_auth_services.dart';
import 'package:utm_counselling_centre/Widgets/AdminDashCard.dart';
import 'package:utm_counselling_centre/Widgets/Buttons/logOutButton.dart';
import 'package:utm_counselling_centre/Widgets/ScreenHeader.dart';

class AdminDashboard extends StatefulWidget {
  final bool counsellor;
  const AdminDashboard({Key? key, required this.counsellor}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final firebaseAuthService _auth = firebaseAuthService();
  bool newReview = false;
  bool newReport = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            const logOutButton(),
            const ScreenHeader(
              home: false,
              title: 'Admin Dashboard',
            ),
            widget.counsellor
                ? Column(
                    children: [
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: IconButton(
                      //         onPressed: () {
                      //           Navigator.pushNamed(context, '/notification');
                      //         },
                      //         icon: const Icon(
                      //           Icons.notifications_sharp,
                      //           size: 35,
                      //           color: AppColors.tertiaryColor,
                      //         )),
                      //   ),
                      // ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AdminManageSchedule(
                                            counsellor: true)));
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                            child:
                                Image(image: AssetImage('assets/myschedule.png')),
                          )),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AdminPatientReports(
                                            counsellor: true)));
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                            child:
                                Image(image: AssetImage('assets/patientsstate.png')),
                          )),
                      // const AdminDashCard(
                      //   image: 'assets/patientsstate.png',
                      //   route: '/adminpatient',
                      // ),
                      const AdminDashCard(
                        image: 'assets/feedback.png',
                        route: '/adminfeed',
                      ),
                    ],
                  )
                : Column(
                    children:   [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const AdminManageSchedule(
                                        counsellor: false)));
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                            child:
                            Image(image: AssetImage('assets/myschedule.png')),
                          )),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const AdminPatientReports(
                                        counsellor: false)));
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                            child:
                            Image(image: AssetImage('assets/patientsstate.png')),
                          )),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
