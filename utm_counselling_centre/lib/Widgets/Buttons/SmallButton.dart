import 'package:flutter/material.dart';
class SmallButton extends StatelessWidget {
  final title;
  final route;
  const SmallButton ({Key? key, this.title, this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, route);
      },
      child: Container(
        // height: 50,
        // width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xff811DFF),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 10, 22, 10),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),

          ),
        ),
      ),
    );
  }
}
