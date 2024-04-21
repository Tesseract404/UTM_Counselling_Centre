import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
class FeedCard extends StatelessWidget {
  final title;
  final date ;
  const FeedCard({Key? key, this.title, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        print('tapped');
        showDialog<void>(
          context: context,
          //barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              title: const Center(
                child: Text(
                  'Patient 1',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.pGreyColor,
                    borderRadius:BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: const Text(
                      "I wanted to express my sincere appreciation for the incredible support you've provided me. Your compassionate approach and expertise have made a significant impact on my mental well-being. I'm grateful for the progress I've made under your care. Your ability to create a safe space and listen attentively has made me feel understood and validated. The techniques and interventions you've introduced have helped me develop coping mechanisms and gain new perspectives. Your guidance has been invaluable, and your kindness and support have made a lasting impact. Thank you for your exceptional professionalism and genuine care." ,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child:  Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.accentColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Image(
                image: AssetImage('assets/default.png'),
              ),
              title: Text(
                title,
              ),
              trailing: Text(
                date,
              ),
            ),
          ),
        ),
      )
    );
  }
}
