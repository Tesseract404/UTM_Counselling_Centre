import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Firebase%20Authentication/firebase_auth_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Constants/AppColors.dart';
import '../Models/ReportsModel.dart';
import '../Models/ScheduleModel.dart';
import '../Widgets/Buttons/Backbutton.dart';
import '../Widgets/Buttons/CustomTinyButton.dart';
import '../Widgets/ScreenHeader.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Schedules extends StatefulWidget {
  const Schedules({Key? key}) : super(key: key);

  @override
  State<Schedules> createState() => _SchedulesState();
}

class _SchedulesState extends State<Schedules> {
  final firebaseAuthService _auth = firebaseAuthService();
  List<ScheduleModel> schedule = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSchedules();
  }

  Future<void> _fetchSchedules() async {
    try {
      List<ScheduleModel> fetchedSchedules = await _auth.fetchUserSchedules();

      fetchedSchedules.sort((a, b) {
        if (a.timedate == null && b.timedate == null) return 0;
        if (a.timedate == null) return 1;
        if (b.timedate == null) return -1;
        return a.timedate!.compareTo(b.timedate!);
      });

      setState(() {
        schedule = fetchedSchedules;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching schedules: $e');
      Fluttertoast.showToast(msg: "Error fetching schedule");
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
    return '$formattedDate , $formattedTime';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Backbutton(),
          const ScreenHeader(
            home: false,
            title: 'Schedules',
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : schedule.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: schedule.length,
                        itemBuilder: (context, index) {
                          final schedules = schedule[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.pGreyColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        leading: (schedules.done ?? true)
                                            ? const Icon(
                                                CupertinoIcons
                                                    .checkmark_alt_circle_fill,
                                                size: 35,
                                                color:
                                                    CupertinoColors.systemGreen,
                                              )
                                            : const Icon(
                                                CupertinoIcons.clock_fill,
                                                size: 35,
                                                color: AppColors
                                                    .secondaryTextColor,
                                              ),
                                        title: Text(
                                          formatTimestamp(
                                            schedules.timedate,
                                          ),
                                          style: const TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            'Counsellor: ${schedules.counsellor}'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'No upcoming session!',
                      ),
                    ],
                  ),
        ],
      ),
    );
  }
}
