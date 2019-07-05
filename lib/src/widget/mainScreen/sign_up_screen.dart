import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../bloc/bloc.dart';
import '../../provider/hexaColorConvert.dart';
import '../../provider/provider_widget.dart';
import '../../provider/provider.dart';
import '../../provider/check_connection.dart';

class sign_up extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return sign_up_state();
  }
}

class sign_up_state extends State<sign_up> {

  bool isProgress = false;
  Widget build(BuildContext context) {
    Bloc bloc = Bloc();
    // Bloc bloc 
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      body: Container(
        child: body(context, bloc),
      ),
    );
    
  }

  Widget body(BuildContext context, Bloc bloc) {
    return Stack(
      children: <Widget>[
        background(),
        SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: Colors.white70),
                ),
                Container(
                  height: 350.0,
                  child: Center(
                    child: logoImage()
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0), 
                  child: user_signup(context, bloc),
                ),
              ],
            ),
          ),
        ),
        isProgress == true ? progress() : Container()
      ],
    );
  }

  Widget user_signup(BuildContext context, Bloc bloc) {
    return StreamBuilder(
      stream: bloc.emailSignUp,
      builder: (context, snapshot){
        return Column(
          children: <Widget>[
            TextField(
              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w300),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 23.0, bottom: 23.0, left: 20.0),
                labelStyle: TextStyle(color: Colors.white30),
                labelText: 'Email',
                enabledBorder: outlineInput(Colors.white30),
                errorText: snapshot.hasError ? snapshot.error : null, 
                focusedBorder: outlineInput(Colors.blueAccent)
              ),
              onChanged: (userInput) {
                bloc.addUsersign(userInput);
              },
            ),
            //Button
            signUpButton(context, snapshot, bloc)
          ],
        );
      },
    );
  }
  Widget signUpButton(BuildContext context, AsyncSnapshot snapshot, Bloc bloc) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: double.infinity,
      decoration: BoxDecoration(
        // boxShadow: [
        //   shadow()
        // ],
        borderRadius: BorderRadius.circular(30.0),
        gradient: LinearGradient(
          colors: [
            Color(hexColor('#f46b45')),
            Color(hexColor('#eea849'))
          ]
        )
      ),
      child: FlatButton(
        padding: EdgeInsets.only(left: 60.0, right: 60.0, top: 20.0, bottom: 20.0),
        textColor: Colors.white,
        child: Text('Sign Up', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18.0)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed: () {
          setState(() => isProgress = true );
          checkConnection(context).then((isConnect){
            if ( isConnect == true ){
              validator(bloc);
            } else {
              setState(() {
                isProgress = false; 
                no_internet(context);
              });
            }
          });
        },
      ),
    );
  }
  validator(Bloc bloc) {
    bloc.registerUser(context)
    .then((onValue){
      setState(() => isProgress = false );
    })
    .catchError((onError){
      setState(() => isProgress = false );
    });
  }
  
  resetBloc(Bloc bloc) {
    bloc.addUsersign(null);
  }
}

