import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'package:utm_counselling_centre/Widgets/Buttons/SmallButton.dart';
class ConfirmButton2 extends StatelessWidget {
  final title;
  final Color color;
  final Function() function;


  const ConfirmButton2({Key? key, this.title,   required this.color,  required this.function,  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: () {if(title!='Cancel') {
          function();
          Navigator.pop(context);
        }
        else {
          Navigator.pop(context);
        }
        },
        child: Container(
          // height: 50,
          width: 145,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color:color    ,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 8, 22, 8),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 13,
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
