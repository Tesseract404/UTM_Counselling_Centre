import 'package:flutter/material.dart';

import '../Widgets/Buttons/Backbutton.dart';
import '../Widgets/FeedCard.dart';
import '../Widgets/ScreenHeader.dart';
class AdminFeed extends StatefulWidget {
  const AdminFeed({Key? key}) : super(key: key);

  @override
  State<AdminFeed> createState() => _AdminFeedState();
}

class _AdminFeedState extends State<AdminFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
        children: [
          Backbutton(),
          const ScreenHeader(
            home: false,
            title: "Patient's Feedback",
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return FeedCard(
                    title: 'Patient $index',
                    date: '12/03/2024',
                  );
                }),
          )
        ],
      ),
    );
  }
}
