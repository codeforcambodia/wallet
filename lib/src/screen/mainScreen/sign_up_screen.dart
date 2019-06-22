import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../bloc/bloc.dart';
import '../../provider/hexaColorConvert.dart';
import '../../model/model.dart';
import '../../provider/provider_widget.dart';

class sign_up extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return sign_up_state();
  }
}

class sign_up_state extends State<sign_up> {
  Widget build(BuildContext context) {
    // Bloc bloc 
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Container(
        child: body(context),
      ),
    );
  }
}

Widget body(BuildContext context) {
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
                child: user_signup(context),
              )
              
            ],
          ),
        ),
      )
    ],
  );
}

Widget user_signup(BuildContext context) {
  return Column(
    children: <Widget>[
      TextField(
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.emailAddress,
        // focusNode: emailNode,
        // onChanged: (term) {
        //   emailNode.unfocus();
        //   FocusScope.of(context).requestFocus(passwordNode);
        // },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 23.0, bottom: 23.0, left: 20.0),
          labelStyle: TextStyle(color: Colors.white30),
          labelText: 'Email',
          enabledBorder: outlineInput(Colors.white30)
        ),
      ),
      //Button
      Container(
        decoration: BoxDecoration(
          boxShadow: [
            shadowButton()
          ]
        ),
        margin: EdgeInsets.all(25.0),
        child: signUpButton(context),
      )
    ],
  );
}



  Widget signUpButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35.0, right: 35.0),
      width: double.infinity,
      decoration: BoxDecoration(
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
          // Map<String, dynamic> userdata = {
          //   'firstName': 'Daveat',
          //   'lastName': 'Corn',
          //   'email': 'condaveat@gmail.com',
          //   'password': '12345',
          //   'confirm_pass': '12345',
          //   'image': 'https://firebasestorage.googleapis.com/v0/b/flutter-236705.appspot.com/o/17499428_1876523952588037_4176834688564950044_n.jpg?alt=media&token=f335c859-e7ab-4670-9ae4-b2a3dcab92a6'
          // };

          // final model = User_Data.userSignUp(userdata);
          // Navigator.push(context, MaterialPageRoute(builder: (context) => home_screen.fromSignUp(model)));
        },
      ),
    );
  }