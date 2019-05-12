import 'package:flutter/material.dart';
import 'dart:ui';
import './homeScreen/home_screen.dart';
import '../model/model.dart';
import '../mixin/validator_mixin.dart';
import '../screen/forgot_password/forgot_password.dart';

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

  FocusNode first_node, second_node = FocusNode();

  final formkey = GlobalKey<FormState>();

  //get user data sign up
  var fullname = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var confirm_password = TextEditingController();

  //body widget
  Widget bodyWidget() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/blur.jpg'),
                  fit: BoxFit.cover,
                )
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2)
                  ),
                ),
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation:  0.0,
              iconTheme: IconThemeData(color: Colors.blueAccent),
            ),
            Container(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    //Image logo
                    Image.asset('assets/abstract_logo_vector.png',width: 300.0, height: 200.0,),
                    Row(children: <Widget>[Text('')],),
                    //Field input
                    showLogin == false ? Column 
                    (
                      children: <Widget>[
                        user_login(),
                        Row(children: <Widget>[Text('')],),
                        //Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            loginBUtton(),
                            haveAccount(),
                          ],
                        ),
                        youForgotPassword()
                      ],
                    ) : Column(
                      children: <Widget>[
                        user_signup(),
                        Row(children: <Widget>[Text('')],),
                        //Button
                        signUpButton(),
                        haveAccount(),
                      ],
                    ),
                    Container(margin: EdgeInsets.only(bottom: 50.0),),
                  ],
                ),
              ),
            ),
          ],
        )
      )
      ,
    );
  }

  //Below is Field input
  Widget user_signup() {
    return Form(
      key: formkey,
      child: Column(
        children: <Widget>[
         TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if ( value == '') return 'Fill Username';
            },
            controller: fullname,
            decoration: InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))
            ),
          ),
          Row(children: <Widget>[Text('')],),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: email,
            validator: validatorEmail,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))
            ),
          ),
          Row(children: <Widget>[Text('')],),
          TextFormField(
            controller: password,
            obscureText: true,
            validator: validatorPassword,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))
            ),
          ),
          Row(children: <Widget>[Text('')],),
          TextFormField(
            validator: (value) {
              if( value == '') {return 'Fill password';}
              else if ( value.length < 4)return 'Password must be 5digit';
              else if ( value != password.toString() )return 'Invalid password';
              else return null;
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Comfirm password',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))
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
         TextFormField(
            textInputAction: TextInputAction.next,
            focusNode: first_node,
            controller: email,
            keyboardType: TextInputType.emailAddress,
            validator: validatorEmail,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
              hintStyle: TextStyle(wordSpacing: 50.0)
            ),
            onFieldSubmitted: (term) {
              first_node.unfocus();
              FocusScope.of(context).requestFocus(second_node);
            },
          ),
          Row(children: <Widget>[Text('')],),
          TextFormField(
            textInputAction: TextInputAction.done,
            focusNode: second_node,
            controller: password,
            obscureText: true,
            validator: validatorPassword,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        // if ( email.text == useremail && password.text == userpasword) {
          if (email.text != '') FocusScope.of(context).requestFocus(second_node);
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
      child: Text('${showLogin == false ? "Sign up" : 'Already have account'}'),
      onPressed: () {
        setState(() {
          if ( showLogin == false ) showLogin = true;
          else showLogin = false;
        });
      },
    );
  }

  Widget youForgotPassword() {
    return FlatButton(
      textColor: Colors.grey,
      child: Text('Forgot password?'),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => forgotPassword()));
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: bodyWidget(),
    );
  }
}