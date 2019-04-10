import 'package:flutter/material.dart';

class fill_field extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return fieldState();
  }
}

class fieldState extends State<fill_field>{
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Color(0xFF18D191)),
      ),
    );
  }
}