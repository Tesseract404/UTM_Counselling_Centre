import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Firebase%20Authentication/firebase_auth_services.dart';
 import 'package:utm_counselling_centre/Widgets/Buttons/ConfirmButton2.dart';
import '../Constants/AppColors.dart';
import '../Models/ReportsModel.dart';
import '../Models/ScheduleModel.dart';
import '../Widgets/Buttons/Backbutton.dart';
import 'dart:async';
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
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _fetchSchedules();
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
      _fetchSchedules();
      // print('refreshed');
    });
  }
  Future<void> _notify() async {
    try{
      await _auth.notifyAllSchedule();
    }catch(e){
      print(e);
    }
  }
  Future<void> _fetchSchedules() async {
    try {
      List<ScheduleModel> fetchedSchedules = await _auth.fetchUserSchedules();
      fetchedSchedules.sort((a, b) {
        if (a.approved == true && b.approved != true) return -1;
        if (a.approved != true && b.approved == true) return 1;
        if (a.timedate == null && b.timedate == null) return 0;
        if (a.timedate == null) return 1;
        if (b.timedate == null) return -1;
        return a.timedate!.compareTo(b.timedate!);
      });

      if (_hasScheduleChanged(schedule, fetchedSchedules)) {
        print('Updated');
        setState(() {
          schedule = fetchedSchedules;
          isLoading = false;
        });
      }else {
         setState(() {
          isLoading = false;
        });
      }

    } catch (e) {
      print('Error fetching schedules: $e');
       setState(() {
        isLoading = false;
      });
    }
  }

  bool _hasScheduleChanged(
      List<ScheduleModel> oldList, List<ScheduleModel> newList) {
    if (oldList.length != newList.length) return true;

    for (int i = 0; i < oldList.length; i++) {
      if (oldList[i].userid != newList[i].userid ||
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
              : schedule.isNotEmpty ? Expanded(
                      child: ListView.builder(
                        itemCount: schedule.length,
                        itemBuilder: (context, index) {
                          final schedules = schedule[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: schedules.approved!?AppColors.pGreyColor: Color(0xfff0dfdf),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
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
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          'Counsellor: ${schedules.counsellor}',
                                          style: const TextStyle(
                                              fontSize: 12,

                                          ),
                                        ),

                                      ),
                                    ),
                                    !schedules.done!?Text(
                                      schedules.approved!
                                          ? 'Approved'
                                          : 'Pending',
                                      style:   TextStyle(fontSize: 11,
                                          color: schedules.approved!?CupertinoColors.activeGreen:Colors.red
                                      ),
                                    ):Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.pushNamed(context, '/feed',arguments: schedules.counsellor);
                                        },
                                        child: Container(
                                          // height: 50,
                                          width: 145,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color:AppColors.secondaryColor    ,
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Center(
                                              child: Text(
                                                'Rate',
                                                style: TextStyle(
                                                  color: AppColors.whiteColor,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),

                                              ),
                                            ),
                                          ),
                                        ),
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
