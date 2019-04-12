import 'package:flutter/material.dart';
import 'dart:ui';
import './home_screen.dart';

class fill_field extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return fieldState();
  }
}

class fieldState extends State<fill_field>{

  bool showLogin = false;
  bool isProgress = false;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Container(
        child: Column(
          children: <Widget>[
            // new Container(
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: new AssetImage('assets/blur.jpg'),
            //       fit: BoxFit.cover
            //     )
            //   ),
            //   child: BackdropFilter(
            //     filter: new ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
            //     child: Container(
            //       decoration: BoxDecoration( 
            //         color: Colors.grey.withOpacity(0.2)
            //       ),
            //     ),
            //   ),
            // ),
            new AppBar(
              backgroundColor: Colors.transparent,
              elevation:  0.0,
              iconTheme: IconThemeData(color: Colors.blueAccent),
            ),
            new Container(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Center(
                child: showLogin == false ? Column(
                  children: <Widget>[
                    //Image logo
                    new Image.asset('assets/abstract_logo_vector.png',width: 300.0, height: 200.0,),
                    new Row(children: <Widget>[Text('')],),
                    //Field input
                    user_login(),
                    new Row(children: <Widget>[Text('')],),
                    //Button
                    loginBUtton(),
                    haveAccount()
                  ],
                ) : Column(
                  children: <Widget>[
                    //Image logo
                    new Image.asset('assets/abstract_logo_vector.png',width: 300.0, height: 200.0,),
                    new Row(children: <Widget>[Text('')],),
                    //Field input
                    user_signup(),
                    new Row(children: <Widget>[Text('')],),
                    //Button
                    signUpButton(),
                    haveAccount()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Below is Field input
  Widget user_signup() {
    return Column(
      children: <Widget>[
        new TextField(
          decoration: new InputDecoration(
            labelText: 'Full Name'
          ),
        )
        ,
        new TextField(
          decoration: new InputDecoration(
            labelText: 'Email',
          ),
        ),
        new TextField(
          obscureText: true,
          decoration: new InputDecoration(
            labelText: 'Password'
          ),
        ),
        new TextField(
          decoration: new InputDecoration(
            labelText: 'Comfirm password'
          ),
        )
      ],
    );
  }

  Widget user_login() {
    return Column(
      children: <Widget>[
        new TextField(
          decoration: new InputDecoration(
            labelText: 'Email'
          ),
        ),
        new TextField(
          decoration: new InputDecoration(
            labelText: 'Password'
          ),
        )
      ],
    );
  }
  
  //Below is button
  Widget signUpButton() {
    return RaisedButton(
      padding: EdgeInsets.only(left: 60.0, right: 60.0),
      color: Colors.amber,
      textColor: Colors.white,
      child: Text('Sign Un'),
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      onPressed: () {
      },
    );
  }

  Widget loginBUtton() {
    return RaisedButton(
      padding: EdgeInsets.only(left: 60.0, right: 60.0),
      color: Colors.amber,
      textColor: Colors.white,
      child: Text('Log In'),
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => home_screen()));
      },
    );
  }
  

  Widget haveAccount() {
    return FlatButton(
      textColor: Colors.lightBlue[300],
      child: Text('${showLogin == false ? 'Sign Up Now' : 'Already have account'}'),
      onPressed: () {
        setState(() {
          if ( showLogin == false ) showLogin = true;
          else showLogin = false;
        });
      },
    );
  }
}