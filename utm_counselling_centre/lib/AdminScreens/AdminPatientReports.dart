import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'package:utm_counselling_centre/Firebase%20Authentication/firebase_auth_services.dart';
import 'package:utm_counselling_centre/Widgets/Buttons/Backbutton.dart';
import '../Models/ReportsModel.dart';
import '../Widgets/Buttons/CustomTinyButton.dart';
import '../Widgets/ScreenHeader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
class AdminPatientReports extends StatefulWidget {
  final bool counsellor;
  const AdminPatientReports({Key? key, required this.counsellor}) : super(key: key);

  @override
  State<AdminPatientReports> createState() => _AdminPatientReportsState();
}

class _AdminPatientReportsState extends State<AdminPatientReports> {
  final firebaseAuthService _auth = firebaseAuthService();
  late List<ReportModel> reports = [];
  bool isLoading = true;
  String? counsellorName;
  @override
  void initState() {
    super.initState();
    initialize();
  }
  void initialize() async {
    await getName();
    if (widget.counsellor && counsellorName != null) {
      _fetchCounsellorReports(counsellorName!);
    } else {
      _fetchAllReports();
    }
  }

  Future<void> getName() async {
    counsellorName = await _auth.getCounsellorName();
    if (counsellorName != null) {
      print('Counsellor Name: $counsellorName');
    } else {
      print('It’s not a counsellor ID');
    }
  }
  Future<void> _fetchAllReports() async {
    try {
      List<ReportModel> fetchedReports = await _auth.fetchAllReports();
      setState(() {
        reports = fetchedReports;
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
  Future<void> _fetchCounsellorReports(String counsellor) async {
    try {
      //print('the name is $counsellorName');
      List<ReportModel> fetchedReports = await _auth.fetchCounsellorReports(counsellor);
      setState(() {
        reports = fetchedReports;
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

  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'Date not available';
    DateTime date = timestamp.toDate();
    String formattedTime = DateFormat.jm().format(date);
    String formattedDate = DateFormat('d MMMM yyyy').format(date);
    return '$formattedTime | $formattedDate';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Backbutton(),
          const ScreenHeader(
            home: false,
            title: 'Patient Report',
          ),
          isLoading?const CircularProgressIndicator()
          : reports.isNotEmpty?Expanded(
            child: ListView.builder(
              itemCount: reports.length ,
              itemBuilder: (context, index) {
                final report = reports[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children:   [
                          Expanded(
                            child: ListTile(
                              leading: const Image(
                                image: AssetImage('assets/default.png'),
                              ),
                              title: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    report.username!,
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.secondaryColor
                                    ),
                                  ),
                                  Text(
                                    report.doctor!,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.tertiaryColor
                                    ),
                                  ),
                                ],
                              ),
                              subtitle:  Text(
                                  formatTimestamp(report.timedate),
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textColor
                                ),
                              ),

                            ),
                          ),
                           CustomTinyButton(
                            title: 'Details', color: AppColors.secondaryColor, content:report.content ,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ):const Center(
            child: Text(
              'No reports available!'
            ),
          ),
        ],
      ),
    );
  }
}
