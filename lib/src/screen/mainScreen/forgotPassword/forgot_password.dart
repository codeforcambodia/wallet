import 'package:flutter/material.dart';

class forgotPassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return forgot_state();
  }
}

class forgot_state extends State<forgotPassword>{
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text('Forgot passowrd'),
          RaisedButton(
            child: Text('Back'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
}