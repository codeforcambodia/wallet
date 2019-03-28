import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn =GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts/readonly',
  ]
);

class home_page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return homepagestate();
  }
}

class homepagestate extends State<home_page>{

  GoogleSignInAccount _currentUser;

  String _contactText;  

  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser =account;
      });
      if (_currentUser != null) {
        google_sign_in();
      }
    });
  }

  Future<void> google_sign_in() async {
    await _googleSignIn.signIn();
  }
  
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign up'),
      ),
      body: Center(
        child: googleSignUp(),
      ),
    );
  }

  Widget googleSignUp() {
    return GoogleSignInButton(
      onPressed: () { google_sign_in(); },
    );
  }

}