import 'package:flutter/material.dart';
import './hexaColorConvert.dart';

//User input Outline
OutlineInputBorder outlineInput(Color mycolor) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: mycolor, width: 3),
    borderRadius: BorderRadius.circular(30.0)
  );
}

//Button shadow
BoxShadow shadowButton(){
  return BoxShadow(
    color: Colors.black45,
    blurRadius: 7.0,
    spreadRadius: 5.0,
    offset: Offset(
      5.0,
      7.0
    )
  );
}

Widget background(){
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(hexColor('#030D1E')),
          Color(hexColor('#030D1E'))
        ]
      )
    ),
  ); 
}

BoxDecoration homeBackground() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(hexColor('#030D1E')),
        Color(hexColor('#030D1E'))
      ]
    )
  );
}

Widget logoImage() {
  return Image.asset(
    'assets/abstract_logo_vector.png',
    width: 300.0,
    height: 200.0,
  );
}