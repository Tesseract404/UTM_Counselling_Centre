import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Backbutton extends StatelessWidget {
  const Backbutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: const Align(
        alignment:Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.fromLTRB(19, 19, 0, 0),
          child: Icon(
           Icons.chevron_left,
            size: 35,
          ),
        ),
      ),
    );
  }
}
