import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'package:intl/intl.dart'; // For date and time formatting

class DashSchedule extends StatelessWidget {
  final String? docName;
  final String? clinic;
  final Timestamp? timedate;
  final bool approved;
  const DashSchedule({
    Key? key,
    this.docName,
    this.clinic,
    this.timedate, required this.approved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? appointmentDate = timedate?.toDate();
    String formattedDate = appointmentDate != null
        ? DateFormat('EEEE, d MMMM yyyy').format(appointmentDate)
        : 'Date not available';
    String formattedTime = appointmentDate != null
        ? DateFormat('h:mm a').format(appointmentDate)
        : 'Time not available';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: approved?AppColors.pGreyColor:Color(0xfff0dfdf),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(17, 8, 0, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                docName ?? 'Doctor Name Unavailable',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(clinic ?? 'Clinic Unavailable'),
              SizedBox(height: 20),
              Text(
                formattedDate,
                style: TextStyle(
                  color: AppColors.secondaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Row(
                children: [
                  Text(
                    formattedTime,
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 29,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          approved?'Approved':'Pending',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 3),
                        Icon(
                          approved?Icons.check_circle:Icons.hourglass_bottom,
                          color: approved?CupertinoColors.activeGreen:Colors.deepOrangeAccent,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
