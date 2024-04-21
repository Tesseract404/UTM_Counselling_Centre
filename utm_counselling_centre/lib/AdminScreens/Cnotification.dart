import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Widgets/ScreenHeader.dart';

import '../Widgets/Buttons/Backbutton.dart';
import '../Widgets/NotificationCard.dart';

class Cnotification extends StatefulWidget {
  const Cnotification({Key? key}) : super(key: key);

  @override
  State<Cnotification> createState() => _CnotificationState();
}

class _CnotificationState extends State<Cnotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Backbutton(),
          ScreenHeader(
            home: false,
            title: 'Notification',
          ), 
          Expanded(
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return NotificationCard(
                    msg: 'Patient 1 booked a schedule for Thursday 23th July ',
                    time: '10.30pm',
                  );
                }),
          )
        ],
      ),
    );
  }
}
