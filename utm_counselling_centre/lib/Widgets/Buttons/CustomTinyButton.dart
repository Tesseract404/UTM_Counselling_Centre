 import 'package:flutter/material.dart';

import '../../Constants/AppColors.dart';
class CustomTinyButton extends StatelessWidget {
  final title;
  final route;
  final Color color;
  const CustomTinyButton({Key? key, this.title, this.route, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap:  (){
          Navigator.popAndPushNamed(context, route);
        },
        child: Container(
          // height: 50,
           decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color:  color   ,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 7, 12, 7),
            child: Center(
              child: Text(
                title,
                style:   const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),

              ),
            ),
          ),
        ),
      ),
    );
  }
}
