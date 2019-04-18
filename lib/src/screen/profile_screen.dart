import 'package:flutter/material.dart';

class profile_screen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return profile_state();
  }
}

class profile_state extends State<profile_screen>{
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hello page 2!'),
      ),
    );
  }
}