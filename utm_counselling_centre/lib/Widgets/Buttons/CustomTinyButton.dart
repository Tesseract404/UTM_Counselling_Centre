 import 'package:flutter/material.dart';

import '../../Constants/AppColors.dart';
import 'ConfirmButton2.dart';
class CustomTinyButton extends StatelessWidget {
  final title;
  final route;
  final Color color;
  final content;
  final Function() onTap;
  const CustomTinyButton({Key? key, this.title, this.route, required this.color, this.content, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap:  (){
          showDialog<void>(
            context: context,
            //barrierDismissible: false,  user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: EdgeInsets.zero,
                title:   const Center(
                  child: Column(
                    children: [
                      Text(
                        'Are you sure you want to approve the report? ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color:AppColors.textColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Make sure everything is okay ',
                        style: TextStyle(
                          fontSize: 11,
                          color:AppColors.secondaryTextColor,
                        ),textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                content:  Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child:   SingleChildScrollView(
                    child: ListBody(
                        children: [Row(
                          children: [
                            Expanded(
                              child: ConfirmButton2(
                                title: 'Yes',
                                color: AppColors.secondaryColor,
                                function: () {
                                  onTap();
                                },
                              ),
                            ),
                            Expanded(
                              child: ConfirmButton2(
                                title: 'No',
                                color: Color(0xff9F9F9F),
                                function: () {
                                  null;
                                },
                              ),
                            ),
                          ],
                        ),]
                    ),
                  ),
                ),
              );
            },
          );
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
