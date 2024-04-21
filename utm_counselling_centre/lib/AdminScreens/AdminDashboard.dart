import 'package:flutter/material.dart';
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
                  children:   [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            onPressed: (){
                              Navigator.pushNamed(context, '/notification');
                            }
                            , icon: Icon(
                          Icons.notifications_active_sharp,
                          size: 35,
                          color: AppColors.secondaryColor ,
                        )),
                      ),
                    ),
                    const AdminDashCard(
                      image: 'assets/myschedule.png',
                      route: '/adminmanage',
                    ),
                    const AdminDashCard(
                      image: 'assets/patientsstate.png',
                      route: '/adminpatient',
                    ),
                    const AdminDashCard(
                      image: 'assets/feedback.png',
                      route: '/adminpatient',
                    ),
                  ],
                )
              : Column(
                  children: const [
                    AdminDashCard(
                      image: 'assets/manageB.png',
                      route: '/adminmanage',
                    ),
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
