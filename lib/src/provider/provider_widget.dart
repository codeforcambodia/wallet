import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './hexaColorConvert.dart';
import 'dart:async';

//User input Outline
String color = "#1C2C44";
// '#030D1E'
OutlineInputBorder outlineInput(Color mycolor) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: mycolor, width: 3),
    borderRadius: BorderRadius.circular(30.0)
  );
}

//Button shadow
BoxShadow shadow(){
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
          Color(hexColor(color)),
          Color(hexColor(color))
        ]
      )
    ),
  ); 
}

BoxDecoration homeBackground() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(hexColor(color)),
        Color(hexColor(color))
      ]
    )
  );
}

Widget logoImage() {
  return Image.asset(
    'assets/abstract_logo_vector.png',
    width: 250.0,
    height: 150.0,
  );
}

void dialog(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(text),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    }
  );
}

Widget progress() {
  return Center(child: CircularProgressIndicator(),);
}

void timer(Function fc) {
  Timer(Duration(seconds: 7), (){
    fc();
  });
}