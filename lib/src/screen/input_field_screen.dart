import 'package:flutter/material.dart';
import 'dart:ui';

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
      // ,
      body: new Container(
        child: Column(
          children: <Widget>[
            new AppBar(
              backgroundColor: Colors.transparent,
              elevation:  0.0,
              iconTheme: IconThemeData(color: Colors.blueAccent),
            ),
            new Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: new AssetImage('assets/field_image.jpg'),
                  fit: BoxFit.cover
                )
              ),
              child: BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2)
                  ),
                ),
              ),
            ),
            new Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    new Image.asset('assets/abstract_logo_vector.png',width: 300.0, height: 200.0,),
                    new Row(children: <Widget>[Text('')],),
                    new TextField(
                      decoration: new InputDecoration(
                        labelText: 'Text',
                      ),
                    ),
                    new TextField(
                      obscureText: true,
                      decoration: new InputDecoration(
                        labelText: 'Password'
                      ),
                    ),
                    new Row(children: <Widget>[Text('')],),
                    new RaisedButton(
                      padding: EdgeInsets.only(left: 50.0, right: 50.0),
                      color: Colors.amber,
                      textColor: Colors.white,
                      child: Text('Sign In'),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}