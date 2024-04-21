import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'package:utm_counselling_centre/Firebase%20Authentication/firebase_auth_services.dart';
import 'package:utm_counselling_centre/Models/CounsellorModel.dart';
import 'package:utm_counselling_centre/Models/ScheduleModel.dart';
import 'package:utm_counselling_centre/Widgets/Buttons/logOutButton.dart';
import 'package:utm_counselling_centre/Widgets/DashboardHeaders.dart';
import 'package:utm_counselling_centre/Widgets/DocCard.dart';
 import 'dart:async';
import '../Constants/Flush.dart';
import '../Widgets/Buttons/ConfirmButton2.dart';
import '../Widgets/DashSchedule.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final firebaseAuthService _auth = firebaseAuthService();
  List<CounsellorModel> counsellors = [];
  List<ScheduleModel> upComingScheduleDetails = [];
  List<ScheduleModel> cachedScheduleDetails = [];
  bool isLoading = true;
  bool newSchedule = false;
  bool newReport = false;
  bool upComingSchedule = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeDashboard();
    _startPeriodicFetch();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _initializeDashboard() async {
    await _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    setState(() {
      isLoading = true;
    });

    await _checkForApprovedSchedule();
    await _checkForApprovedReports();
    await _checkForUpcomingSchedule();
    await _getUpcomingSchedule();
    await _fetchCounsellors();

    setState(() {
      isLoading = false;
    });
  }

  void _startPeriodicFetch() {
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) async {
      await _checkForUpdates();
      print('Periodic check completed.');
    });
  }

  Future<void> _checkForUpdates() async {
    bool shouldUpdate = false;

    bool hasUnnotifiedSchedules = await _auth.hasUnnotifiedApprovedSchedules();
    bool hasUpcomingSchedules = await _auth.hasUpcomingSchedules();
    bool hasUnnotifiedReports = await _auth.hasUnnotifiedApprovedReports();

    if (hasUnnotifiedSchedules != newSchedule) {
      newSchedule = hasUnnotifiedSchedules;
      shouldUpdate = true;
    }

    if (hasUpcomingSchedules != upComingSchedule) {
      upComingSchedule = hasUpcomingSchedules;
      shouldUpdate = true;
    }

    if (hasUnnotifiedReports != newReport) {
      newReport = hasUnnotifiedReports;
      shouldUpdate = true;
    }

    List<ScheduleModel> newSchedules = await _auth.UpcomingSchedules();
    if (newSchedules != cachedScheduleDetails) {
      cachedScheduleDetails = newSchedules;
      upComingScheduleDetails = newSchedules;
      shouldUpdate = true;
    }

    if (shouldUpdate && mounted) {
      setState(() {});
    }
  }

  Future<void> _checkForApprovedSchedule() async {
    try {
      bool hasUnnotified = await _auth.hasUnnotifiedApprovedSchedules();
      if (!mounted) return;
      setState(() {
        newSchedule = hasUnnotified;
      });
    } catch (e) {
      print('Error checking schedules: $e');
      Flush.showFlushBar('Error checking approved schedules.');
     }
  }

  Future<void> _checkForUpcomingSchedule() async {
    try {
      bool hasUpcoming = await _auth.hasUpcomingSchedules();
      if (!mounted) return;
      setState(() {
        upComingSchedule = hasUpcoming;
      });
    } catch (e) {
      print('Error checking schedules: $e');
     }
  }

  Future<void> _getUpcomingSchedule() async {
    try {
      List<ScheduleModel> upcomingSchedules = await _auth.UpcomingSchedules();
      if (!mounted) return;

      if (upcomingSchedules != cachedScheduleDetails) {
        setState(() {
          upComingScheduleDetails = upcomingSchedules;
          cachedScheduleDetails = upcomingSchedules;
        });
      }
    } catch (e) {
      print('Error fetching schedules: $e');
     }
  }

  Future<void> _checkForApprovedReports() async {
    try {
      bool hasUnnotified = await _auth.hasUnnotifiedApprovedReports();
      if (!mounted) return;
      setState(() {
        newReport = hasUnnotified;
      });
    } catch (e) {
      print('Error checking reports: $e');
     }
  }

  Future<void> _fetchCounsellors() async {
    try {
      List<CounsellorModel> fetchCounsellors = await _auth.fetchCounsellorDetails();
      if (!mounted) return;

      setState(() {
        counsellors = fetchCounsellors;
      });
    } catch (e) {
      print('Error fetching counsellors: $e');
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const logOutButton(),
            Padding(
              padding: const EdgeInsets.only(top: 1),
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
                  isLoading?'Loading...'
                  :upComingSchedule
                      ? 'Your current upcoming session'
                      : 'Our Doctors and Counsellors',
                  style:   TextStyle(
                    color: isLoading?AppColors.pGreyColor:AppColors.textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: isLoading?18:22,
                  ),
                 ),
              ),
            ),
            isLoading
                ? LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.secondaryColor,
              ),
            )
                : Expanded(
              child: upComingSchedule
                  ? _buildUpcomingSchedules()
                  : _buildCounsellors(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingSchedules() {
    return ListView.builder(
      itemCount: upComingScheduleDetails.length,
      itemBuilder: (context, index) {
        final schedule = upComingScheduleDetails[index];
        return DashSchedule(
          docName: schedule.counsellor,
          clinic: 'AU Clinic',
          timedate: schedule.timedate,
          approved: schedule.approved!,
        );
      },
    );
  }

  Widget _buildCounsellors() {
    return ListView.builder(
      itemCount: counsellors.length,
      itemBuilder: (context, index) {
        final counsellor = counsellors[index];
        return DocCard(
          docName: counsellor.name!,
          degree: counsellor.degree!,
          clinic: counsellor.clinic_name!,
          email: counsellor.email!,
          image: counsellor.image!,
        );
      },
    );
  }
}
