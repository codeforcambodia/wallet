import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './src/screen/login_screen.dart';
import './src/screen/input_field_screen.dart';
import './src/screen/homeScreen/home_screen.dart';
import './src/screen/input_field_screen.dart';

void main () {
  // debugPaintSizeEnabled = true;
  runApp(App());
}

class App extends StatelessWidget{
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Google sign up",
      home: home_screen(),
    );
  }
}