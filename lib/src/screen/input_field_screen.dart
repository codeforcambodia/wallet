import 'package:flutter/material.dart';
import 'dart:ui';
import './home_screen.dart';
import '../model/model.dart';
import '../mixin/validator_mixin.dart';

class fill_field extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return fieldState();
  }
}

class fieldState extends State<fill_field> with ValidatorMixin{

  String useremail = "condaveat@gmail.com";
  String userpasword = "1234";

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
        child: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              new Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/blur.jpg'),
                    fit: BoxFit.cover,
                  )
                ),
                child: BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2)
                    ),
                  ),
                ),
              ),
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
                          haveAccount(),
                          forgotPassword()
                        ],
                      ) : Column(
                        children: <Widget>[
                          user_signup(),
                          new Row(children: <Widget>[Text('')],),
                          //Button
                          signUpButton(),
                          haveAccount(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        )
        ,
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
            validator: (value) {
              if ( value == '') return 'Fill Username';
            },
            controller: fullname,
            decoration: new InputDecoration(
              labelText: 'Full Name'
            ),
          )
          ,
          new TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: email,
            validator: validatorEmail,
            decoration: new InputDecoration(
              labelText: 'Email',
            ),
          ),
          new TextFormField(
            controller: password,
            obscureText: true,
            validator: validatorPassword,
            decoration: new InputDecoration(
              labelText: 'Password'
            ),
          ),
          new TextFormField(
            validator: (value) {
              if( value == '') {return 'Fill password';}
              else if ( value.length < 4)return 'Password must be 5digit';
              else if ( value != password.toString() )return 'Invalid password';
              else return null;
            },
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
            controller: email,
            keyboardType: TextInputType.emailAddress,
            validator: validatorEmail,
            decoration: new InputDecoration(
              labelText: 'Email'
            ),
          ),
          new TextFormField(
            controller: password,
            obscureText: true,
            validator: validatorPassword,
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
        // if ( email.text == useremail && password.text == userpasword) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home_screen()));
        //   print('Success');
        // } else print('Not yet');
        // formkey.currentState.validate();
      },
    );
  }

  Widget haveAccount() {
    return FlatButton(
      textColor: Colors.lightBlue[300],
      child: Text('${showLogin == false ? "DON'T HAVE AN ACCOUNT" : 'Already have account'}'),
      onPressed: () {
        setState(() {
          if ( showLogin == false ) showLogin = true;
          else showLogin = false;
        });
      },
    );
  }

  Widget forgotPassword() {
    return FlatButton(
      textColor: Colors.grey,
      child: Text('Forgot password?'),
      onPressed: () {},
    );
  }
}