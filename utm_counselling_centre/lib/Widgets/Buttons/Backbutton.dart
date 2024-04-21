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
      child: Align(
        alignment:Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(19.0),
          child: const Icon(
           Icons.chevron_left,
            size: 35,
          ),
        ),
      ),
    );
  }
}
