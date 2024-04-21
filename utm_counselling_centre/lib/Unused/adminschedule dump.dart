// import 'dart:async';
// import 'dart:collection';
// import 'dart:core';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:utm_counselling_centre/Constants/AppColors.dart';
// import 'package:utm_counselling_centre/Constants/utils.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:utm_counselling_centre/Firebase%20Authentication/firebase_auth_services.dart';
// import 'package:utm_counselling_centre/Widgets/Buttons/CustomTinyButton.dart';
// import '../Models/ScheduleModel.dart';
// import '../Widgets/Buttons/Backbutton.dart';
// import '../Widgets/Buttons/ConfirmButton.dart';
// import '../Widgets/Buttons/ConfirmButton2.dart';
// import '../Widgets/ScreenHeader.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
//
// class AdminManageSchedule extends StatefulWidget {
//   final bool counsellor;
//   const AdminManageSchedule({Key? key, required this.counsellor}) : super(key: key);
//
//   @override
//   State<AdminManageSchedule> createState() => _AdminManageScheduleState();
// }
//
// class _AdminManageScheduleState extends State<AdminManageSchedule> with SingleTickerProviderStateMixin {
//   DateTime today = DateTime.now();
//   ValueNotifier<List<Event>>? _selectedEvents;
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   // RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   // DateTime? _rangeStart;
//   // DateTime? _rangeEnd;
//   final firebaseAuthService _auth = firebaseAuthService();
//   String? docName;
//   late List<bool> _isExpandedList; // List to track the expansion state
//   late List<bool> doneStatus;
//   List<ScheduleModel> schedule = [];
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   bool isLoading = true;
//   bool done = false;
//   Map<DateTime, List<Event>> _events = {}; // Initialize an empty map
//   Map<DateTime, List<Event>> _groupEventsByDate(List<ScheduleModel> schedules) {
//     Map<DateTime, List<Event>> events = {};
//
//     for (var schedule in schedules) {
//       Timestamp? timestamp = schedule.timedate;
//       if (timestamp != null) {
//         print('yes Bro');
//         DateTime date = timestamp.toDate();
//         DateTime normalizedDate = DateTime(date.year, date.month, date.day,date.hour,date.minute);
//
//         if (!events.containsKey(normalizedDate)) {
//           events[normalizedDate] = [];
//         }
//
//         Event event = Event(schedule.username ?? 'Unknown User');
//         events[normalizedDate]!.add(event);
//         print('Event added: ${event.title} on $normalizedDate');
//       }
//     }
//     print('Grouped Events: $events');
//     return events;
//   }
//   @override
//   void initState() {
//     super.initState();
//     initialize();
//     // _selectedDay = _focusedDay;
//     //  _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//     _fadeAnimation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     );
//   }
//
//   @override
//   void dispose() {
//     //_selectedEvents?.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   void initialize() async {
//     await getName();
//     if (docName != null) {
//       widget.counsellor ? await _fetchCounsellorSchedules(docName!) : await _fetchSchedules();
//     } else {
//       await _fetchSchedules();
//     }
//     setState(() {
//       // _events = _groupEventsByDate(schedule);
//       //_selectedEvents!.value = _getEventsForDay(_selectedDay!);
//     });
//   }
//
//   Future<void> getName() async {
//     docName = await _auth.getCounsellorName();
//   }
//
//   Future<void> _fetchSchedules() async {
//     try {
//       List<ScheduleModel> fetchedSchedules = await _auth.fetchAllSchedules();
//       fetchedSchedules.sort((a, b) {
//         if (a.timedate == null && b.timedate == null) return 0;
//         if (a.timedate == null) return 1;
//         if (b.timedate == null) return -1;
//         return a.timedate!.compareTo(b.timedate!);
//       });
//       setState(() {
//         schedule = fetchedSchedules;
//         _isExpandedList = List<bool>.filled(schedule.length, false);
//         doneStatus = List<bool>.filled(schedule.length, false);
//         isLoading = false;
//       });
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error fetching schedule");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   Future<void> _fetchCounsellorSchedules(String? counsellor) async {
//     try {
//       List<ScheduleModel> fetchedSchedules = await _auth.fetchCounsellorSchedules(counsellor!);
//       fetchedSchedules.sort((a, b) {
//         if (a.timedate == null && b.timedate == null) return 0;
//         if (a.timedate == null) return 1;
//         if (b.timedate == null) return -1;
//         return a.timedate!.compareTo(b.timedate!);
//       });
//       setState(() {
//         schedule = fetchedSchedules;
//         _isExpandedList = List<bool>.filled(schedule.length, false);
//         doneStatus = List<bool>.filled(schedule.length, false);
//         _events = _groupEventsByDate(schedule);
//         isLoading = false;
//       });
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error fetching schedule");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   Future<void> _meetingDone(String scheduleId) async {
//     try {
//       await _auth.updateScheduleDone(scheduleId);
//       await _fetchSchedules();
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   String formatTimestamp(Timestamp? timestamp) {
//     if (timestamp == null) return 'Date not available';
//     DateTime date = timestamp.toDate();
//     String formattedTime = DateFormat.jm().format(date);
//     String formattedDate = DateFormat('d MMMM yyyy').format(date);
//     return '$formattedDate, $formattedTime';
//   }
//
//   List<DateTime> daysInRange(DateTime first, DateTime last) {
//     final dayCount = last.difference(first).inDays + 1;
//     return List.generate(
//       dayCount,
//           (index) => DateTime.utc(first.year, first.month, first.day + index),
//     );
//   }
//
//   List<Event> _getEventsForDay(DateTime day) {
//     return _events[day] ?? [];
//   }
//
//
//
//   List<Event> _getEventsForRange(DateTime start, DateTime end) {
//     final days = daysInRange(start, end);
//     return [
//       for (final d in days) ..._getEventsForDay(d),
//     ];
//   }
//
//   // void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//   //   if (!isSameDay(_selectedDay, selectedDay)) {
//   //     setState(() {
//   //       _selectedDay = selectedDay;
//   //       _focusedDay = focusedDay;
//   //       _rangeStart = null;
//   //       _rangeEnd = null;
//   //       _rangeSelectionMode = RangeSelectionMode.toggledOff;
//   //     });
//   //    // String A= _datetimeToTimeStamp(selectedDay);
//   //     print((selectedDay));
//   //     _selectedEvents!.value = _getEventsForDay(selectedDay);
//   //   }
//   // }
//
//
//   // void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
//   //   setState(() {
//   //     _selectedDay = null;
//   //     _focusedDay = focusedDay;
//   //     _rangeStart = start;
//   //     _rangeEnd = end;
//   //     _rangeSelectionMode = RangeSelectionMode.toggledOn;
//   //   });
//   //
//   //   if (start != null && end != null) {
//   //     _selectedEvents!.value = _getEventsForRange(start, end);
//   //   } else if (start != null) {
//   //     _selectedEvents!.value = _getEventsForDay(start);
//   //   } else if (end != null) {
//   //     _selectedEvents!.value = _getEventsForDay(end);
//   //   }
//   // }
//   void _datetimeToTimeStamp(DateTime datetime) {
//     int timestamp = datetime.millisecondsSinceEpoch;
//     print('Timestamp: $timestamp');
//
//   }
//   Future<void> _approveSchedule(String id) async {
//     try {
//       await _auth.approveSchedule(id);
//       print('Schedule approved');
//       await _fetchSchedules();
//     } catch (e) {
//       print(e);
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return widget.counsellor? Scaffold(
//       body: Column(
//         children: [
//           const Backbutton(),
//           const ScreenHeader(home: false, title: 'Manage Schedules'),
//           // Padding(
//           //     padding: const EdgeInsets.all(8.0),
//           //     child: TableCalendar<Event>(
//           //       firstDay: kFirstDay,
//           //       lastDay: kLastDay,
//           //       focusedDay: _focusedDay,
//           //       selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//           //       rangeStartDay: _rangeStart,
//           //       headerStyle: const HeaderStyle(
//           //         formatButtonVisible: false,
//           //         titleCentered: true,
//           //       ),
//           //       rangeEndDay: _rangeEnd,
//           //       calendarFormat: _calendarFormat,
//           //       rangeSelectionMode: _rangeSelectionMode,
//           //       eventLoader: _getEventsForDay,
//           //       startingDayOfWeek: StartingDayOfWeek.monday,
//           //       calendarStyle: CalendarStyle(
//           //         outsideDaysVisible: false,
//           //       ),
//           //       onDaySelected: _onDaySelected,
//           //       onRangeSelected: _onRangeSelected,
//           //       onFormatChanged: (format) {
//           //         if (_calendarFormat != format) {
//           //           setState(() {
//           //             _calendarFormat = format;
//           //           });
//           //         }
//           //       },
//           //       onPageChanged: (focusedDay) {
//           //         _focusedDay = focusedDay;
//           //       },
//           //     )
//           // ),
//           Text('nothing here'),
//           const SizedBox(height: 8.0),
//           Expanded(
//             child: ValueListenableBuilder<List<Event>>(
//               valueListenable: _selectedEvents!,
//               builder: (context, value, _) {
//                 if (value.isEmpty) {
//                   return const Center(child: Text('No events for selected day.'));
//                 }
//                 return ListView.builder(
//                   itemCount: value.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: const EdgeInsets.symmetric(
//                         horizontal: 12.0,
//                         vertical: 4.0,
//                       ),
//                       decoration: BoxDecoration(
//                         border: Border.all(),
//                         borderRadius: BorderRadius.circular(12.0),
//                       ),
//                       child: ListTile(
//                         onTap: () => print('${value[index]}'),
//                         title: Text('${value[index].title}'),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     ):Scaffold(
//       body: Column(
//         children: [
//           const Backbutton(),
//           const ScreenHeader(
//             home: false,
//             title: 'Manage Schedules',
//           ),
//           isLoading
//               ? const CircularProgressIndicator()
//               : schedule.isNotEmpty
//               ? Expanded(
//             child: ListView.builder(
//               itemCount: schedule.length,
//               itemBuilder: (context, index) {
//                 final schedules = schedule[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 500),
//                     curve: Curves.easeInOut,
//                     decoration: BoxDecoration(
//                       color: schedules.approved!?AppColors.pGreyColor: Color(0xfff0dfdf),
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     padding: const EdgeInsets.all(14.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Display schedule date
//                         Row(
//                           children: [
//                             Expanded(
//                               flex:3,
//                               child: Text(
//                                 formatTimestamp(schedules.timedate),
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             ),
//                             !schedules.approved!?Expanded(
//                               flex: 1,
//                               child: CustomTinyButton(
//                                 title: 'Approve',
//                                 color: AppColors.secondaryColor,
//                                 onTap: () {
//                                   _approveSchedule(schedules.scheduleid!);
//                                 } ,),
//                             ):const Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Icon(CupertinoIcons.checkmark_alt_circle_fill,color: CupertinoColors.systemGreen,),
//                             ),
//                           ],
//                         ),
//                         Text(schedules.counsellor!),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               _isExpandedList[index] = !_isExpandedList[index];
//                               _isExpandedList[index]
//                                   ? _animationController.forward()
//                                   : _animationController.reverse();
//                             });
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               const Text(
//                                 'Manage',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   color: AppColors.secondaryTextColor,
//                                   fontSize: 13,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 3),
//                                 child: Icon(
//                                   _isExpandedList[index]
//                                       ? Icons.arrow_drop_up
//                                       : Icons.arrow_drop_down,
//                                   size: 18,
//                                   color: AppColors.tertiaryColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizeTransition(
//                           sizeFactor: _fadeAnimation,
//                           child: _isExpandedList[index]
//                               ? Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Patient’s Name: ${schedules.username!}'),
//                               Text('UTMid: ${schedules.UTMid!}'),
//                               const SizedBox(height: 6),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 5),
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         if (!schedules.done! && !doneStatus[index]) {
//                                           showDialog<void>(
//                                             context: context,
//                                             builder: (BuildContext context) {
//                                               return AlertDialog(
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius: BorderRadius.circular(10.0),
//                                                 ),
//                                                 contentPadding: EdgeInsets.zero,
//                                                 title: const Center(
//                                                   child: Text(
//                                                     'Are you sure?',
//                                                     style: TextStyle(
//                                                       fontWeight: FontWeight.w600,
//                                                       fontSize: 16,
//                                                       color: AppColors.textColor,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 content: Padding(
//                                                   padding: const EdgeInsets.all(10),
//                                                   child: SingleChildScrollView(
//                                                     child: ListBody(
//                                                       children: [
//                                                         Row(
//                                                           children: [
//                                                             Expanded(
//                                                               child: ConfirmButton2(
//                                                                 title: 'Yes',
//                                                                 color: AppColors.secondaryColor,
//                                                                 function: () {
//                                                                   _meetingDone(schedules.scheduleid!);
//                                                                   setState(() {
//                                                                     doneStatus[index] = true;
//                                                                   });
//                                                                 },
//                                                               ),
//                                                             ),
//                                                             Expanded(
//                                                               child: ConfirmButton2(
//                                                                 title: 'No',
//                                                                 color: const Color(0xff9F9F9F),
//                                                                 function: () {
//                                                                   Navigator.of(context).pop();
//                                                                 },
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                           );
//                                         }
//                                       },
//                                       child: schedules.done!
//                                           ? Container(
//                                         decoration: BoxDecoration(
//                                           color: AppColors.pGreyColor,
//                                           borderRadius: BorderRadius.circular(5),
//                                         ),
//                                         child: const Padding(
//                                           padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
//                                           child: Row(
//                                             children: [
//                                               Icon(
//                                                 Icons.check_circle,
//                                                 color: AppColors.whiteColor,
//                                                 size: 15,
//                                               ),
//                                               SizedBox(width: 5),
//                                               Text(
//                                                 'Done',
//                                                 style: TextStyle(
//                                                   color: AppColors.sGreyColor,
//                                                   fontSize: 13,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       )
//                                           : Container(
//                                         decoration: BoxDecoration(
//                                           color: AppColors.primaryColor,
//                                           borderRadius: BorderRadius.circular(5),
//                                         ),
//                                         child: const Padding(
//                                           padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
//                                           child: Row(
//                                             children: [
//                                               Icon(
//                                                 Icons.check_circle,
//                                                 color: AppColors.whiteColor,
//                                                 size: 15,
//                                               ),
//                                               SizedBox(width: 5),
//                                               Text(
//                                                 'Mark as Done',
//                                                 style: TextStyle(
//                                                   color: AppColors.sGreyColor,
//                                                   fontSize: 13,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           )
//                               : const SizedBox(),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           )
//               : const Center(
//             child: Text('No available schedule!'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
