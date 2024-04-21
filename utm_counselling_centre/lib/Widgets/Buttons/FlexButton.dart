import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'package:utm_counselling_centre/Widgets/Buttons/SmallButton.dart';

import 'ConfirmButton2.dart';
class FlexButton extends StatelessWidget {
  final title;
  final Color color;
  final Function() function;


  const FlexButton({Key? key, this.title,   required this.color,  required this.function,  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: () {if(title!='Cancel') {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: EdgeInsets.zero,
                title: const Center(
                  child: Text(
                    'Are you sure?',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                content: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ConfirmButton2(
                                title: 'Yes',
                                color: AppColors.secondaryColor,
                                function: () {
                                   function();
                                },
                              ),
                            ),
                            Expanded(
                              child: ConfirmButton2(
                                title: 'No',
                                color: const Color(0xff9F9F9F),
                                function: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );

        }
        else {
          Navigator.pop(context);
        }
        },
        child: Container(
          // height: 50,
          //width: 145,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color:color    ,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
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
