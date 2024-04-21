import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'package:utm_counselling_centre/Firebase%20Authentication/firebase_auth_services.dart';
import 'package:utm_counselling_centre/Widgets/ScreenHeader.dart';

class Results extends StatefulWidget {
  final bool done;
  final counsellor;
  const Results({Key? key,   required this.done, this.counsellor}) : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  final firebaseAuthService _auth = firebaseAuthService();
  @override

  Future<void> _checkSchedule() async {
    await null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ScreenHeader(title: 'Results',home: true,),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.pGreyColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Icon(
                                CupertinoIcons.checkmark_alt_circle_fill,
                                color: Colors.green,
                                size: 20,
                              ),
                            ),
                            Expanded(
                              flex: 9,
                              child: Text(
                                'Your answers has been submitted successfully. Check your results below.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(15, 50, 0, 8),
                        child: Text(
                          'Current state brief:',
                          style: TextStyle(
                            color: AppColors.secondaryTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 17.5,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 80),
                        child: Text(
                          "It is recommended that Patient A attend regular therapy sessions to monitor his progress and make any necessary adjustments to his treatment plan. Close collaboration between the therapist, psychiatrist (if medication is prescribed), and any other healthcare professionals involved in his care is essential to ensure a comprehensive approach to his mental health.",
                          style: TextStyle(
                            color: AppColors.secondaryTextColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.center,
                      //   child: Padding(
                      //     padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
                      //     child: GestureDetector(
                      //       onTap: () {
                      //          !widget.done?Navigator.pushNamed(context, '/feed',arguments: widget.counsellor):null;
                      //       },
                      //       child: Container(
                      //         decoration: BoxDecoration(
                      //             color: widget.done?AppColors.secondaryColor:AppColors.secondaryTextColor,
                      //             borderRadius: BorderRadius.circular(10)),
                      //         child:   Padding(
                      //           padding: EdgeInsets.symmetric(vertical: 10,horizontal: 36),
                      //           child: Text(
                      //             'Met your Counselor? Send Feed back',
                      //             style: TextStyle(
                      //                 color: widget.done? AppColors.whiteColor: AppColors.pGreyColor,
                      //                 fontWeight: FontWeight.w500,
                      //                 fontSize: 13),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        CupertinoIcons.info_circle_fill,
                        color: AppColors.secondaryTextColor,
                        size: 14,
                      ),
                      Expanded(
                        flex: 9,
                        child: Text(
                          ' Counselor will be advising you once you visit for counseling',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: AppColors.secondaryTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
