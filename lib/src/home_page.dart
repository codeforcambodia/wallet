import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class home_page extends StatelessWidget{

  // GoogleSignIn _googleSignIn = new GoogleSignIn(
  //   scopes: [
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly'
  //   ]
  // );

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
  }
  // Future<bool> loginWithGoogle() async{
  //   final api = awit 
  // } 
}