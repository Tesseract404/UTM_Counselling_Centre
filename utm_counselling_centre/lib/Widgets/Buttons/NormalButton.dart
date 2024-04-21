import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
class NormalButton extends StatelessWidget {
  final title;
  final route;
  final Color color;
  const NormalButton({Key? key, this.title, this.route, required this.color}) : super(key: key);

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
          width: 145,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:  color   ,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 10, 22, 10),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 15,
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
