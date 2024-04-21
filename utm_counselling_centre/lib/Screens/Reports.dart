import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Firebase%20Authentication/firebase_auth_services.dart';
 import 'package:utm_counselling_centre/Screens/Results.dart';
import '../Constants/AppColors.dart';
import '../Models/ReportsModel.dart';
import '../Widgets/Buttons/Backbutton.dart';
import '../Widgets/ScreenHeader.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  final firebaseAuthService _auth = firebaseAuthService();
  List<ReportModel> reports = [];
  bool isLoading = true;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _fetchReports();
    _notify();
    _startPeriodicFetch();

  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startPeriodicFetch() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      _fetchReports();
      // print('refreshed');
    });
  }
 Future<void> _notify() async {
   try{
      await _auth.notifyAllReports();
    }catch(e){
     print(e);
   }
  }
  Future<void> _fetchReports() async {
    try {
      List<ReportModel> fetchedReports = await _auth.fetchUserReports();
      fetchedReports.sort((a, b) {
        if (a.approved == true && b.approved != true) return -1;
        if (a.approved != true && b.approved == true) return 1;
        if (a.timedate == null && b.timedate == null) return 0;
        if (a.timedate == null) return 1;
        if (b.timedate == null) return -1;
        return a.timedate!.compareTo(b.timedate!);
      });
      if (_hasScheduleChanged(reports, fetchedReports)) {
        print('Updated');
        setState(() {
          reports = fetchedReports;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching reports: $e');
       setState(() {
        isLoading = false;
      });
    }
  }

  bool _hasScheduleChanged(
      List<ReportModel> oldList, List<ReportModel> newList) {
    if (oldList.length != newList.length) return true;
    for (int i = 0; i < oldList.length; i++) {
      if (oldList[i].id != newList[i].id ||
          oldList[i].timedate != newList[i].timedate ||
          oldList[i].approved != newList[i].approved) {
        return true;
      }
    }
    return false;
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
            title: 'Reports',
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : reports.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: reports.length,
                        itemBuilder: (context, index) {
                          final report = reports[index];
                          return report.approved!
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.accentColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: ListTile(
                                              title: Text(
                                                report.doctor!,
                                                style: const TextStyle(
                                                    color: AppColors
                                                        .secondaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 19),
                                              ),
                                              subtitle: Text(
                                                formatTimestamp(
                                                    report.timedate),
                                                style: const TextStyle(
                                                    color: AppColors
                                                        .secondaryColor,
                                                    fontSize: 15),
                                              ),
                                              trailing: IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Results(
                                                                  done: false,
                                                                  counsellor: report
                                                                      .doctor!)));
                                                },
                                                icon: const Icon(
                                                  CupertinoIcons.right_chevron,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : reports.isEmpty
                                  ? const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'No Report available!',
                                        ),
                                      ],
                                    )
                                  : null;
                        },
                      ),
                    )
                  : const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'No Report available!',
                        ),
                      ],
                    ),
        ],
      ),
    );
  }
}
