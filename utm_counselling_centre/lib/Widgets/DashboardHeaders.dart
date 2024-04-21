import 'package:flutter/material.dart';
class DashboardHeaders extends StatelessWidget {
  final String image;
  final route;
  const DashboardHeaders({Key? key, required this.image, this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, route);
        },
        child: Image(
            image: AssetImage(
             image,
            )),
      ),
    );
  }
}
