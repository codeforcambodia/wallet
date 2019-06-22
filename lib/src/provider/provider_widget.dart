import 'package:flutter/material.dart';

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
