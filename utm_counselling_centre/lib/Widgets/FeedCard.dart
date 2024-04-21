import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
class FeedCard extends StatelessWidget {
  final title;
  final double rating;
  final date ;
  const FeedCard({Key? key, this.title, this.date, required this.rating}) : super(key: key);

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
              title:   Center(
                child: Column(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star_rate,size: 22,color: AppColors.primaryColor,
                        ),
                        SizedBox(width: 5),
                        Text(
                          rating.toString(),
                          style:   const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.pGreyColor,
                    borderRadius:BorderRadius.circular(10.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
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
              subtitle: Text(
                date,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_rate,size: 15,color: AppColors.primaryColor,
                  ),
                  SizedBox(width: 2,),
                  Text(
                    '${rating.toString()}/6',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
