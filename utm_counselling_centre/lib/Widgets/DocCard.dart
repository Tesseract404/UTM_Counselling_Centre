import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Constants/AppColors.dart';
import '../Firebase Authentication/firebase_auth_services.dart';
import '../Models/ScheduleModel.dart';
import 'Buttons/ConfirmButton.dart';

class DocCard extends StatelessWidget {
  final String docName;
  final String image;
  final String degree;
  final String clinic;
  final String email;

    DocCard({
    Key? key,
    required this.docName,
    required this.image,
    required this.degree,
    required this.clinic,
    required this.email,
  }) : super(key: key);
  final firebaseAuthService _auth = firebaseAuthService();
  void _createSchedule(Timestamp? datetime) async {
    try {
      await _auth.createSchedule(ScheduleModel(
        counsellor: docName,
        timedate: datetime,
        done: false,
        approved: false,
        notified: false,
      ));
      //print('im here');
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffECDDFF),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Container(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: image.isNotEmpty
                          ? Image.network(
                        image,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.person);
                        },
                      )
                          : Icon(Icons.error),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 25, 0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          docName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                          ),
                        ),
                        Text(
                          degree,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          clinic,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Text(
                                email,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: AppColors.primaryColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: email));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Email copied to clipboard'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.copy,
                                size: 16,
                                color: AppColors.secondaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                print('tapped');
                _showScheduleDialog(context, docName);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xff5D3392),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(22, 5, 22, 5),
                      child: Text(
                        'Check Schedules',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontWeight: FontWeight.w200,
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
    );
  }

  void _showScheduleDialog(BuildContext context, String docName) {
    final ValueNotifier<DateTime?> selectedDate = ValueNotifier<DateTime?>(null);
    final ValueNotifier<TimeOfDay?> selectedTime = ValueNotifier<TimeOfDay?>(null);

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: const Center(
            child: Text(
              'Select Schedule',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 19,
                color: Colors.black87,
              ),
            ),
          ),
          content: Container(
            constraints: BoxConstraints(maxHeight: 300),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ValueListenableBuilder<DateTime?>(
                  valueListenable: selectedDate,
                  builder: (context, value, child) {
                    return ElevatedButton(
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1),
                        );
                        if (pickedDate != null) {
                          selectedDate.value = pickedDate;
                        }
                      },
                      child: Text(
                        value == null
                            ? 'Select Date'
                            : 'Selected Date: ${value.toString().split(' ')[0]}',
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                ValueListenableBuilder<TimeOfDay?>(
                  valueListenable: selectedTime,
                  builder: (context, value, child) {
                    return ElevatedButton(
                      onPressed: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          selectedTime.value = pickedTime;
                        }
                      },
                      child: Text(
                        value == null ? 'Select Time' : 'Selected Time: ${value.format(context)}',
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    final DateTime? selectedDateTime = selectedDate.value != null && selectedTime.value != null
                        ? DateTime(
                      selectedDate.value!.year,
                      selectedDate.value!.month,
                      selectedDate.value!.day,
                      selectedTime.value!.hour,
                      selectedTime.value!.minute,
                    )
                        : null;

                    if (selectedDateTime != null) {
                      Navigator.of(context).pop();
                      showDialog<void>(
                        context: context,
                        //barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                            title:   Column(
                              children: [
                                const Center(
                                  child: Text(
                                    'Confirm Your Appointment',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    docName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:AppColors.primaryColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            content: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: SingleChildScrollView(
                                child: ListBody(
                                  children: [
                                    const Center(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(0, 18, 0, 20),
                                        child: Text(
                                          'Sunday - 10am-1pm',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: ConfirmButton(
                                              title: 'Confirm Booking',
                                              color: Color(0xff5D3392),
                                              function: () {
                                                Timestamp timestamp = Timestamp.fromDate(selectedDateTime);
                                                _createSchedule(timestamp);
                                              }, counsellor: docName,
                                            )),
                                        Expanded(
                                          child: ConfirmButton(
                                            title: 'Cancel',
                                            color: Color(0xff9F9F9F),
                                            function: () {
                                              null;
                                            }, counsellor: ' ',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select date and time'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(17, 7, 17, 7),
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 15
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
