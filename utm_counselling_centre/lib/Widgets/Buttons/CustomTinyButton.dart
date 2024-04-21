 import 'package:flutter/material.dart';

import '../../Constants/AppColors.dart';
class CustomTinyButton extends StatelessWidget {
  final title;
  final route;
  final Color color;
  final content;
  const CustomTinyButton({Key? key, this.title, this.route, required this.color, this.content}) : super(key: key);

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
                title: const Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: Text(
                      'Report Details',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                content: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(7, 3, 7, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.pGreyColor,
                        borderRadius: BorderRadius.circular(7)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          content,
                          style: const TextStyle(
                            color: AppColors.secondaryTextColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
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
