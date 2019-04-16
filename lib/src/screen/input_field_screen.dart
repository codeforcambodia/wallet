import 'package:flutter/material.dart';
import 'dart:ui';
import './home_screen.dart';
import '../model/model.dart';

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
  final formkey = GlobalKey<FormState>();

  //get user data sign up
  var fullname = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var confirm_password = TextEditingController();

  // Map<String, TextEditingController> 

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
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
                child: Column(
                  children: <Widget>[
                    //Image logo
                    new Image.asset('assets/abstract_logo_vector.png',width: 300.0, height: 200.0,),
                    new Row(children: <Widget>[Text('')],),
                    //Field input
                    showLogin == false ? Column 
                    (
                      children: <Widget>[
                        user_login(),
                        new Row(children: <Widget>[Text('')],),
                        //Button
                        loginBUtton(),
                        haveAccount()  
                      ],
                    ) : Column(
                      children: <Widget>[
                        user_signup(),
                        new Row(children: <Widget>[Text('')],),
                        //Button
                        signUpButton(),
                        haveAccount()
                      ],
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

  //Below is Field input
  Widget user_signup() {
    return Form(
      key: formkey,
      child: Column(
        children: <Widget>[
          new TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: fullname,
            decoration: new InputDecoration(
              labelText: 'Full Name'
            ),
          )
          ,
          new TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: email,
            validator: (value) => value.contains('@') ? null : 'Invalid email',
            decoration: new InputDecoration(
              labelText: 'Email',
            ),
          ),
          new TextFormField(
            controller: password,
            obscureText: true,
            validator: (value) => value.length > 4 ? null : 'Invalid password',
            decoration: new InputDecoration(
              labelText: 'Password'
            ),
          ),
          new TextFormField(
            controller: confirm_password,
            obscureText: true,
            decoration: new InputDecoration(
              labelText: 'Comfirm password'
            ),
          )
        ],
      )
    );
  }

  Widget user_login() {
    return Form(
      key: formkey,
      child: Column(
        children: <Widget>[
          new TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (value) => value.contains('@') ? null : 'Invalid Email',
            decoration: new InputDecoration(
              labelText: 'Email'
            ),
          ),
          new TextFormField(
            validator: (value) => value.length >= 4 ? null : 'Invalid password',
            decoration: new InputDecoration(
              labelText: 'Password'
            ),
          )
        ],
      )
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
        print(fullname.text);
        print(email.text);
        print(password.text);
        print(confirm_password.text);
        formkey.currentState.validate();
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
        formkey.currentState.validate();
        // Navigator.push(context, MaterialPageRoute(builder: (context) => home_screen()));
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