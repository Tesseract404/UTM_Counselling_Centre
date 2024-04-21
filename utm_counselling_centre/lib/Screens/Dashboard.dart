import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'package:utm_counselling_centre/Firebase%20Authentication/firebase_auth_services.dart';
import 'package:utm_counselling_centre/Models/CounsellorModel.dart';
import 'package:utm_counselling_centre/Widgets/Buttons/logOutButton.dart';
import 'package:utm_counselling_centre/Widgets/DashboardHeaders.dart';
import 'package:utm_counselling_centre/Widgets/DocCard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import '../Widgets/Buttons/ConfirmButton2.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final firebaseAuthService _auth = firebaseAuthService();
  List<CounsellorModel> counsellors = [];
  bool isLoading = true;
  bool newSchedule = false;
  bool newReport = false;
  bool upComingSchedule = false;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _checkForApprovedSchedule();
    _checkForApprovedReports();
    _checkForUpcomingSchedule();

    ///_checkForUpcomingSchedule();//rated//stateChanged
    _fetchCounsellors();
    print('Counsellors fetched: ${counsellors.length}');
    _startPeriodicFetch();
  }

  // Future<void> intializer() async {
  //   await _checkForApprovedSchedule()?newSchedule=true:false;
  // }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startPeriodicFetch() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      await _checkForApprovedSchedule();
      await _checkForApprovedReports();
      await _checkForUpcomingSchedule();
      print('Checked for new schedules.');
    });
  }

  Future<void> _checkForApprovedSchedule() async {
    try {
      bool hasUnnotified = await _auth.hasUnnotifiedApprovedSchedules();
      //print('new notification = $hasUnnotified');
      setState(() {
        newSchedule = hasUnnotified;
      });
    } catch (e) {
      print('Error checking schedules: $e');
    }
  }

  Future<void> _checkForUpcomingSchedule() async {
    try {
      bool Upcoming = await _auth.hasUpcomingSchedules();
      //print('new notification = $hasUnnotified');
      setState(() {
        upComingSchedule = Upcoming;
      });
    } catch (e) {
      print('Error checking schedules: $e');
    }
  }

  Future<void> _checkForApprovedReports() async {
    try {
      bool hasUnnotified = await _auth.hasUnnotifiedApprovedReports();
      print('new notification = $hasUnnotified');
      setState(() {
        newReport = hasUnnotified;
      });
    } catch (e) {
      print('Error checking report: $e');
    }
  }

  Future<void> _fetchCounsellors() async {
    try {
      List<CounsellorModel> fetchCounsellors =
          await _auth.fetchCounsellorDetails();
      setState(() {
        counsellors = fetchCounsellors;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching reports: $e');
      Fluttertoast.showToast(msg: "Error fetching reports");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const logOutButton(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                  child: Text(
                    'COUNSELLING CENTER',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 38,
                      fontFamily: GoogleFonts.oswald().fontFamily,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: DashboardHeaders(
                        image: 'assets/reports.png',
                        route: '/report',
                        notify: newReport,
                      ),
                    ),
                    Expanded(
                      child: DashboardHeaders(
                        image: 'assets/bookings.png',
                        route: '/schedule',
                        notify: newSchedule,
                      ),
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text(
                        upComingSchedule
                            ? 'Our Doctors and Counsellors'
                            : 'You current upcoming session',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                    )),
              ],
            ),
            isLoading
                ? const CircularProgressIndicator()
                : !upComingSchedule
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: counsellors.length,
                          itemBuilder: (context, index) {
                            final counsellor = counsellors[index];
                            return
                                //Container(color: Colors.red,height: 21, width: double.infinity,);
                                DocCard(
                              docName: counsellor.name!,
                              degree: counsellor.degree!,
                              clinic: counsellor.clinic_name!,
                              email: counsellor.email!,
                              image: counsellor.image!,
                            );
                          },
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: counsellors.length,
                          itemBuilder: (context, index) {
                            final counsellor = counsellors[index];
                            return
                                //Container(color: Colors.red,height: 21, width: double.infinity,);
                                DocCard(
                              docName: counsellor.name!,
                              degree: counsellor.degree!,
                              clinic: counsellor.clinic_name!,
                              email: counsellor.email!,
                              image: counsellor.image!,
                            );
                          },
                        ),
                      )
          ],
        ),
      ),
    );
  }
}
