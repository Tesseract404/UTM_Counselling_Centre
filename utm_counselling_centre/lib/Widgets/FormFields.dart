import 'package:flutter/material.dart';
class FormFields extends StatelessWidget {
  final title;

  const FormFields({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:   const EdgeInsets.fromLTRB(10, 12, 10, 0),
      child: TextFormField(

          cursorColor:Color(0xff5D3392) ,
          decoration:   InputDecoration(
              labelText: title,
            labelStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xff5D3392),
                fontWeight: FontWeight.w500
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color:Color(0xff5D3392) )
            )
            // hintText: title,
            // hintStyle:const TextStyle(
            //     fontSize: 14,
            //     fontWeight: FontWeight.w500
            // ),
          )
      ),
    );
  }
}
