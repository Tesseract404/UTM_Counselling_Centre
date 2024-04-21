import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
class NotificationCard extends StatelessWidget {
  final msg;
  final time;
  const NotificationCard({Key? key, this.msg, this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.pGreyColor,
        ),
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image(
              image: AssetImage(
                'assets/notify.png'
              ),
            ),
          ),
          title: Text(
            msg,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.fromLTRB(1, 5, 0, 0),
            child: Text(
              time,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                color: AppColors.secondaryTextColor
              ),
            ),
          ),
        ),
      ),
    );
  }
}
