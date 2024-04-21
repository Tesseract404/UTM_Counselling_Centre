import 'dart:async';
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'package:utm_counselling_centre/Firebase%20Authentication/firebase_auth_services.dart';
import 'package:utm_counselling_centre/Models/ScheduleModel.dart';
import 'package:utm_counselling_centre/Widgets/Buttons/Backbutton.dart';
import 'package:utm_counselling_centre/Widgets/Buttons/FlexButton.dart';
import 'package:utm_counselling_centre/Widgets/ScreenHeader.dart';

import '../Constants/Flush.dart';
import '../Widgets/Buttons/ConfirmButton2.dart';
import '../Widgets/Buttons/CustomTinyButton.dart';

class AdminManageSchedule extends StatefulWidget {
  final bool counsellor;

  const AdminManageSchedule({Key? key, required this.counsellor})
      : super(key: key);

  @override
  _AdminManageScheduleState createState() => _AdminManageScheduleState();
}

class _AdminManageScheduleState extends State<AdminManageSchedule> with SingleTickerProviderStateMixin{
  DateTime today = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  final firebaseAuthService _auth = firebaseAuthService();
  List<ScheduleModel> schedule = [];
  LinkedHashMap<DateTime, List<ScheduleModel>> _events = LinkedHashMap();
  bool isLoading = true;
  Timer? _timer;
  late List<bool> doneStatus ;
  String? docName;
  @override
  void initState() {
    super.initState();
    initialize();
    _startPeriodicFetch();

  }


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startPeriodicFetch() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      widget.counsellor?_fetchCounsellorSchedules(docName!):_fetchSchedules();
      // print('refreshed');
    });
  }
  void initialize() async {
    await getName();
    if (docName != null) {
      widget.counsellor
          ? await _fetchCounsellorSchedules(docName!)
          : await _fetchSchedules();
    } else {
      await _fetchSchedules();
    }
    _prepareEvents();
  }
  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'Date not available';
    DateTime date = timestamp.toDate();
    String formattedTime = DateFormat.jm().format(date);
    String formattedDate = DateFormat('d MMMM yyyy').format(date);
    return '$formattedDate , $formattedTime';
  }
  Future<void> getName() async {
    docName = await _auth.getCounsellorName();
  }
  Future<void> _meetingDone(String scheduleId) async {
    try {
      await _auth.updateScheduleDone(scheduleId);
      _fetchSchedules();
    } catch (e) {
      print(e);
    }
  }
  Future<void> _fetchSchedules() async {
    try {
      List<ScheduleModel> fetchedSchedules = await _auth.fetchAllSchedules();
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
       Flush.showFlushBar( 'Error fetching schedule');
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> _approveSchedule( String id) async {
    try{
      await _auth.approveSchedule(id);
      setState(() {
        for (var scheduleItem in schedule) {
          if (scheduleItem.scheduleid == id) {
            scheduleItem.approved = true;
            break;
          }
        }
      });
      print('done');
      _prepareEvents();
    }catch(e){
      print(e);
    }
  }
  Future<void> _fetchCounsellorSchedules(String counsellor) async {
    try {
      List<ScheduleModel> fetchedSchedules =
      await _auth.fetchCounsellorSchedules(counsellor);
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
      Flush.showFlushBar( 'Error fetching schedule');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _prepareEvents() {
    for (var item in schedule) {
      DateTime date = item.timedate!.toDate();
      DateTime day = DateTime(date.year, date.month, date.day);
      if (_events[day] == null) {
        _events[day] = [];
      }
      _events[day]!.add(item);
    }
  }

  List<ScheduleModel> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          const Backbutton(),
          const ScreenHeader(home: false, title: 'Manage Schedules'),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
              children: [
                _buildCalendar(),
                const SizedBox(height: 16.0),
                Expanded(
                  child: _buildEventList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildCalendar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: today,
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                today = focusedDay;
              });
            },
            eventLoader: _getEventsForDay,
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: AppColors.secondaryColor.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: AppColors.tertiaryColor,
                shape: BoxShape.circle,
              ),
              markersAlignment: Alignment.bottomCenter,
              markersMaxCount: 3,
              markerDecoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
              weekendTextStyle: const TextStyle(
                color: AppColors.pGreyColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekendStyle: TextStyle(color: Colors.redAccent),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              leftChevronIcon: Icon(Icons.chevron_left, color: AppColors.primaryColor),
              rightChevronIcon: Icon(Icons.chevron_right, color: AppColors.primaryColor),
              titleTextStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildEventList() {
    List<ScheduleModel> selectedEvents = _getEventsForDay(_selectedDay);
    if (selectedEvents.isEmpty) {
      return const Center(child: Text('No schedules for this day'));
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 9),
      child: ListView.builder(
        itemCount: selectedEvents.length,
        itemBuilder: (context, index) {
          ScheduleModel event = selectedEvents[index];
          return Card(
            color: AppColors.accentColor,
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(event.username ?? 'No Name',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              subtitle: Text(DateFormat('hh:mm a').format(event.timedate!.toDate()),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: AppColors.primaryColor),),
              trailing: Container(
                width:MediaQuery.of(context).size.width * 0.2,
                height:MediaQuery.of(context).size.height * 0.05,
                child: !event.approved!?FlexButton(
                  title: 'Approve',
                  color: AppColors.secondaryColor,
                  function: () {
                    _approveSchedule(event.scheduleid!);
                  },
                ):const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(CupertinoIcons.checkmark_alt_circle_fill,color: CupertinoColors.systemGreen,),
                ),
              ),
              onTap: () {
                _showEventDetails(event);
              },
            ),
          );
        },
      ),
    );
  }

  void _showEventDetails(ScheduleModel event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Schedule Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Name: ${event.username ?? 'No Name'}'),
              Text('UTM ID: ${event.UTMid ?? 'No UTM ID'}'),
              Text('Counsellor: ${event.counsellor ?? 'No Counsellor'}'),
              Text(
                  'Date: ${DateFormat('d MMMM yyyy').format(event.timedate!.toDate())}'),
              Text(
                  'Time: ${DateFormat('hh:mm a').format(event.timedate!.toDate())}'),
              SizedBox(height: 20),
              !event.done!?FlexButton(title: 'Mark as Done',color: AppColors.tertiaryColor, function: (){_meetingDone(event.scheduleid!); }):SizedBox(),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

