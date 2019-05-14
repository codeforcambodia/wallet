import 'package:flutter/material.dart';
import 'dart:ui';
import './homeScreen/home_screen.dart';
import '../model/model.dart';
import '../mixin/validator_mixin.dart';
import '../screen/forgot_password/forgot_password.dart';

class fill_field extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return fieldState();
  }
}

class fieldState extends State<fill_field> with ValidatorMixin {
  String useremail = "condaveat@gmail.com";
  String userpassword = "1234";

  bool showLogin = false;
  bool isProgress = false;

  final formkey = GlobalKey<FormState>();

  //User login
  final FocusNode first_node = FocusNode();
  final FocusNode second_node = FocusNode();

  //User signUp
  final FocusNode fullnameNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode conFirmPasswordNode = FocusNode();

  //get user data sign up
  String fullname, email, password, confirm_password;
  
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
            )),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
              ),
            ),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.blueAccent),
          ),
          Container(
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  //Image logo
                  Image.asset(
                    'assets/abstract_logo_vector.png',
                    width: 300.0,
                    height: 200.0,
                  ),
                  Row(
                    children: <Widget>[Text('')],
                  ),
                  //Field input
                  showLogin == false
                      ? Column(
                          children: <Widget>[
                            user_login(),
                            Row(
                              children: <Widget>[Text('')],
                            ),
                            //Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                loginButton(),
                                signUpAndHaveAccount(),
                              ],
                            ),
                            youForgotPassword()
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            user_signup(),
                            Row(
                              children: <Widget>[Text('')],
                            ),
                            //Button
                            signUpButton(),
                            signUpAndHaveAccount(),
                          ],
                        ),
                  Container(
                    margin: EdgeInsets.only(bottom: 50.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  //Below is Field input
  Widget user_signup() {
    return Form(
        key: formkey,
        child: Column(
          children: <Widget>[
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              focusNode: fullnameNode,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0))
              ),
              onFieldSubmitted: (term) {
                fullnameNode.unfocus();
                FocusScope.of(context).requestFocus(emailNode);
              },
              validator: (value) {
                if (value == '') return 'Fill Username';
              },
              onSaved: (value) {
                fullname = value;
              },
            ),
            Row(
              children: <Widget>[Text('')],
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validator: validatorEmail,
              focusNode: emailNode,
              onFieldSubmitted: (term) {
                emailNode.unfocus();
                FocusScope.of(context).requestFocus(passwordNode);
              },
              onSaved: (value) {
                email = value; 
              },
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0))),
            ),
            Row(
              children: <Widget>[Text('')],
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              obscureText: true,
              validator: validatorPassword,
              focusNode: passwordNode,
              onFieldSubmitted: (term) {
                passwordNode.unfocus();
                FocusScope.of(context).requestFocus(conFirmPasswordNode);
              },
              onSaved: (value) {
                password = value;
              },
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0))),
            ),
            Row(
              children: <Widget>[Text('')],
            ),
            TextFormField(
              validator: (value) {
                if (value == '') {
                  return 'Fill password';
                } else if (value.length < 4)
                  return 'Password must be 5digit';
                else if (value != password.toString())
                  return 'Invalid password';
                else
                  return null;
              },
              obscureText: true,
              focusNode: conFirmPasswordNode,
              textInputAction: TextInputAction.done,
              onSaved: (value) {
                confirm_password = value;
              },
              decoration: InputDecoration(
                  labelText: 'Comfirm password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0))),
            )
          ],
        ));
  }

  Widget user_login() {
    return Form(
      // key: formkey,
      child: Column(
        children: <Widget>[
          TextFormField(
            textInputAction: TextInputAction.next,
            focusNode: first_node,
            keyboardType: TextInputType.emailAddress,
            validator: validatorEmail,
            decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                hintStyle: TextStyle(wordSpacing: 50.0)),
            onFieldSubmitted: (term) {
              first_node.unfocus();
              FocusScope.of(context).requestFocus(second_node);
            },
            onSaved: (value) {

            },
          ),
          Row(
            children: <Widget>[Text('')],
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            focusNode: second_node,
            obscureText: true,
            validator: validatorPassword,
            decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0))),
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
        formkey.currentState.save();
        print(fullname);
        print(email);
        print(password);
        print(confirm_password);
        // formkey.currentState.validate();
      },
    );
  }

  Widget loginButton() {
    return RaisedButton(
      padding: EdgeInsets.only(left: 60.0, right: 60.0),
      color: Colors.amber,
      textColor: Colors.white,
      child: Text('Log In'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        formkey.currentState.reset();
        // if ( email.text == useremail && password.text == userpasword) {
        // if (email.text != '') FocusScope.of(context).requestFocus(second_node);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => home_screen()));
        //   print('Success');
        // } else print('Not yet');
        // formkey.currentState.validate();
      },
    );
  }

  Widget signUpAndHaveAccount() {
    return FlatButton(
      textColor: Colors.lightBlue[300],
      child: Text('${showLogin == false ? "Sign up" : 'Already have account'}'),
      onPressed: () {
        setState(() {
          if (showLogin == false)
            showLogin = true;
          else
            showLogin = false;
        });
      },
    );
  }

  Widget youForgotPassword() {
    return FlatButton(
      textColor: Colors.grey,
      child: Text('Forgot password?'),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => forgotPassword()));
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
