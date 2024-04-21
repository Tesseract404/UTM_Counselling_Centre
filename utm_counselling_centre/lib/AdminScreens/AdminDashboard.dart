import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Widgets/ScreenHeader.dart';
class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:   [
          const ScreenHeader(home: false,title: 'Admin Dashboard',),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/adminmanage');
            },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: Image(image: AssetImage('assets/manageB.png')),
              )),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/adminpatient');
            },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: Image(image: AssetImage('assets/patientB.png')),
              )),
        ],
      ),
    );
  }
}
