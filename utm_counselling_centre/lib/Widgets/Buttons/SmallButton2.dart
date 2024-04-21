import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
class SmallButton2 extends StatelessWidget {
  final title;
  final Function? function;
  final   argument;
  const SmallButton2 ({Key? key, this.title,  this.function, this.argument,  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (function != null) {
          function!();
        }
       // Navigator.popAndPushNamed(context, route,arguments: argument);
      },
      child: Container(
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
