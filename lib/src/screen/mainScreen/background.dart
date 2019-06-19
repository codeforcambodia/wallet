import 'package:flutter/material.dart';
import '../../provider/hexaColorConvert.dart';

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

Widget logoImage() {
  return Image.asset(
    'assets/abstract_logo_vector.png',
    width: 300.0,
    height: 200.0,
  );
}