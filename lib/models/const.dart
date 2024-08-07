import 'dart:ui';

import 'package:flutter/material.dart';

Color mainColor = Color(0xFFFFA62F);
Color secondaryColor = Color(0xFFFFC96F);
Color tempColor = Color(0xFFFFE8C8);

TextStyle itemMenu = TextStyle(
  fontWeight: FontWeight.bold,
);

double getMainHeight(BuildContext context){
  return MediaQuery.of(context).size.height;
}

double getMainWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}

class InputFieldCustom extends StatelessWidget{

  final TextEditingController controller;
  final String hintText;
  final bool isObsucre;
  InputFieldCustom({required this.controller, required this.hintText, required this.isObsucre});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      
      margin: EdgeInsets.only(left: 20, right: 20),

      padding: EdgeInsets.all(5),

      child: TextFormField(
        controller: controller,
        obscureText: isObsucre,

        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: secondaryColor, width: 1, style: BorderStyle.solid)
          ),
        ),
      ),
      
    );
  }

}