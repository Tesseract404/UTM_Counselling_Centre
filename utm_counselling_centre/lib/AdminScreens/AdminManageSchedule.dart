import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';

import '../Widgets/ScreenHeader.dart';
class AdminManageSchedule extends StatefulWidget {
  const AdminManageSchedule({Key? key}) : super(key: key);

  @override
  State<AdminManageSchedule> createState() => _AdminManageScheduleState();
}


class _AdminManageScheduleState extends State<AdminManageSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ScreenHeader(home: false, title: 'Manage Schedules'),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.pGreyColor,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 8, 0, 8),
                          child: Text('Name'),
                        ),
                      ),
                      Expanded(
                        flex:9,
                        child: Row(
                          children: const [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Sun'),
                              ),
                            ),
                            Expanded(
                              child: Padding(  
                                padding: EdgeInsets.all(8.0),
                                child: Text('Mon'),
                              ),
                            ),
                            Expanded(
                              child: Padding( 
                                padding: EdgeInsets.all(8.0),
                                child: Text('Tue'),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Wed'),
                              ),
                            ),
                            Expanded(
                              child: Padding(  
                                padding: EdgeInsets.all(8.0),
                                child: Text('Thu'),
                              ),
                            ),
                            Expanded(
                              child: Padding( 
                                padding: EdgeInsets.all(8.0),
                                child: Text('Fri'),
                              ),
                            ),
                            Expanded(
                              child: Padding( 
                                padding: EdgeInsets.all(8.0),
                                child: Text('Sat'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount:  5,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 0, 8),
                                child: Text('Counselor A'),
                              ),
                            ),
                            Expanded(
                              flex: 9,
                              child: Row(
                                children: const [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('--'),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding( 
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('--'),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding( 
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('1:30'),
                                    ),
                                  ),
                                  Expanded(
                                     child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('1:00'),
                                  ),
                                   ),
                                  Expanded(
                                    child: Padding( 
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('--'),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding( 
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('2:00'),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding( 
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('--'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

