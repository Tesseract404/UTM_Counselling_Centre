import 'package:flutter/material.dart';
class FormFields extends StatelessWidget {
  final title;
  final TextEditingController? controller;
  final TextInputType? txtinp;
   final bool password  ;

  const FormFields({Key? key, this.title, required this.controller, required this.txtinp, required this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,),
      child: TextFormField(
          obscureText: password,
          keyboardType:  txtinp,
          controller: controller,
          keyboardAppearance: Brightness.dark,
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
