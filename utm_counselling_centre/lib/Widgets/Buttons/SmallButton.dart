import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
class SmallButton extends StatelessWidget {
  final title;
  final route;
  final Function? function;
  const SmallButton ({Key? key, this.title, this.route, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (function != null) {
          function!();
        }
        Navigator.popAndPushNamed(context, route);
      },
      child: Container(
        // height: 50,
        // width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 10, 22, 10),
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),

          ),
        ),
      ),
    );
  }
}
