import 'package:flutter/material.dart';

class setting extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return setting_state();
  }
}

class setting_state extends State<setting>{
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setting')),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('setting'),
            new RaisedButton(
              child: Text('Sign out'),
            )
          ],
        ),
      ),
    );
  }
}