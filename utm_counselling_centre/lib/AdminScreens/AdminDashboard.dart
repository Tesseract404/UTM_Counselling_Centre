import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/AdminScreens/AdminManageSchedule.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'package:utm_counselling_centre/Widgets/AdminDashCard.dart';
import 'package:utm_counselling_centre/Widgets/ScreenHeader.dart';

class AdminDashboard extends StatefulWidget {
  final bool counsellor;
  const AdminDashboard({Key? key, required this.counsellor}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const ScreenHeader(
            home: false,
            title: 'Admin Dashboard',
          ),
          widget.counsellor
              ? Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/notification');
                            },
                            icon: Icon(
                              Icons.notifications_active_sharp,
                              size: 35,
                              color: AppColors.secondaryColor,
                            )),
                      ),
                    ),
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
                    const AdminDashCard(
                      image: 'assets/patientsstate.png',
                      route: '/adminpatient',
                    ),
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
                    AdminDashCard(
                      image: 'assets/patientB.png',
                      route: '/adminpatient',
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
