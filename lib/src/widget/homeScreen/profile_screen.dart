import 'package:flutter/material.dart';
import 'dart:async';
import '../../bloc/bloc.dart';
import '../../provider/provider.dart';
import './drawer.dart';

class profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return profile_state();
  }
}

class profile_state extends State<profile>{

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawerOnly(signOut),
      appBar: AppBar(title: Text('Profile',)),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Profile'),
            new RaisedButton(
              child: Text('Sign out'),
            )
          ],
        ),
      ),
    );
  }
  void signOut() {
    print('Hello sign out');
    // if(widget.google != null) widget.google.signOut();
    // setState(() {
    //   isProgress = true;
    // });
    Timer(Duration(seconds: 2), () {
      // setState(() {
        // isProgress = false;
      // });
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
    });
  }
}