import 'package:flutter/material.dart';
import './src/home_page.dart';

class App extends StatelessWidget{
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Google sign up",
      home: home_page(),
    );
  }
}