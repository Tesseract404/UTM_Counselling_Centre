import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'package:utm_counselling_centre/Firebase%20Authentication/firebase_auth_services.dart';
import 'package:utm_counselling_centre/Models/ScheduleModel.dart';
import 'package:utm_counselling_centre/Widgets/Buttons/ConfirmButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SlotCard extends StatelessWidget {
  final String? counsellor;
  SlotCard({Key? key,  this.counsellor}) : super(key: key);
  final firebaseAuthService _auth = firebaseAuthService();
  void _createSchedule() async {
    try {
      await _auth.createSchedule(ScheduleModel(
        counsellor: counsellor,
        timedate: Timestamp.now(),
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
    return GestureDetector(
      onTap: () {
        print('tapped');
        Navigator.pop(context);
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
                      counsellor!,
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
                              _createSchedule();
                            }, counsellor: counsellor!,
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
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 6, 10, 0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.pGreyColor),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      'Sunday',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      '10am - 1pm',
                      style: TextStyle(
                        color: Color(0xff4F75FF),
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                    child: Text(
                      'available slots : 2',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
