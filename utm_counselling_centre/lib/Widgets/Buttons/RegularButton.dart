import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
class RegularButton extends StatelessWidget {
    final title;
    final route;
    RegularButton({Key? key, this.title, this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.popAndPushNamed(context, route);
      },
      child: Container(
        height: 50,
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primaryColor
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 19,
              fontWeight: FontWeight.w400,
            ),

          ),
        ),
      ),
    );
  }
}
