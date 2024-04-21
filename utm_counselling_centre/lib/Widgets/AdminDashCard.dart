import 'package:flutter/material.dart';
class AdminDashCard extends StatelessWidget {
  final String image;
  final route;
  const AdminDashCard({Key? key, required this.image, this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child:   Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
          child: Image(image: AssetImage(image)),
        ));
  }
}
