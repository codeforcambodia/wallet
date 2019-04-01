import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly'
  ]
);

class home_page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return homepageState();
  }
}

class homepageState extends State<home_page>{

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account){
      setState(() {
        print(account);
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Sign Up'),),
      body: Center(
        child: Column(
          children: <Widget>[
            googleButton()
          ],
        ),
      ),
    );
  }

  Widget googleButton() {
    return GoogleSignInButton(
      onPressed: () => googleSignUp(),
    );
  }

  void googleSignUp() {
    _googleSignIn.signIn();
  }
}