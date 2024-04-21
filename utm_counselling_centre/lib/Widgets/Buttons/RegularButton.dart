import 'package:flutter/material.dart';
class RegularButton extends StatelessWidget {
    final title;
    final route;
    RegularButton({Key? key, this.title, this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, route);
      },
      child: Container(
        height: 50,
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xff811DFF),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w400,
            ),

          ),
        ),
      ),
    );
  }
}
