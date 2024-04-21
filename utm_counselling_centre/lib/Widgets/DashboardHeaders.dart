import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
class DashboardHeaders extends StatelessWidget {
  final String image;
  final route;
  final bool notify;
  const DashboardHeaders({Key? key, required this.image, this.route, required this.notify}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, route);
        },
        child:Stack(
          clipBehavior: Clip.none,
          children: [
            Image(
                image: AssetImage(
                  image,
                )),
            notify?Positioned(
              top: -6.0,
              right: -6.0,
              child: Container(
                width: 28.0,
                height: 28.0,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 3.0),
                ),
                child: const Center(
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ):const SizedBox(),
          ],
        ),
      ),
    );
  }
}
