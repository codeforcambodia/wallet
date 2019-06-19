import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../model/model.dart';
import './login_screen.dart';
import 'dart:ui';
import '../homeScreen/home_screen.dart';
import 'dart:convert';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:uuid/uuid.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../provider/Data_Store/data_storage.dart';
import '../../query_service/query_service.dart';
import '../../provider/provider.dart';
import '../../bloc/bloc.dart';
import '../../provider/hexaColorConvert.dart';
import './background.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly'
]);

class default_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return loginState();
  }
}

class loginState extends State<default_screen> {
  GoogleSignInAccount user_data;
  
  final String redirectUrl = "https://testnet.zeetomic.com";
  final String clientId = '81l6052tuwhceq';
  final String clientSecret = 'P8T0FNCQJfQ3ArLq';

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          background(),
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 30.0,bottom: 30.0),
                  ),
                  Container(
                    child: Expanded(
                      child: Center(
                        child: logoImage(),
                      ),
                    )
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        login(context),
                        Container(margin: EdgeInsets.only(top: 10.0, bottom: 10.0),),
                        createNewAcc()
                      ],
                    ),
                  ),
                  // Container(margin: EdgeInsets.only(top: 100.0, bottom: 100.0),),

                  // Container(margin: EdgeInsets.only(bottom: 10),),
                  // linkedInButton(),
                  // Container(margin: EdgeInsets.only(bottom: 5),),
                  // googleButton(),
                  // Container(margin: EdgeInsets.only(bottom: 50.0),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget googleButton() {
    if (user_data == null) {
      return GoogleSignInButton(
        darkMode: true,
        onPressed: () {
          googleSignUp();
        },
      );
    } else {
      return IconButton(
        icon: Icon(Icons.power_settings_new),
        iconSize: 28.0,
        onPressed: () {
          googleSignOut();
        },
      );
    }
  }

  Widget linkedInButton() {
    return LinkedInButtonStandardWidget(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => linkedInLogin(),
            // fullscreenDialog: true
          )
        );
      },
    );
  }

  Widget circularProgress() {
    return CircularProgressIndicator();
  }

  Widget login(context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 80.0, right: 80.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 7.0,
            spreadRadius: 5.0,
            offset: Offset(
              5.0,
              7.0
            )
          )
        ],
        borderRadius: BorderRadius.circular(30.0),
        gradient: LinearGradient(
          colors: [
            Color(hexColor('#cB356b')),
            Color(hexColor('##bd3f32')),
          ]
        )
      ),
      child: FlatButton(
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0,),
        textColor: Colors.white,
        child: Text('Login & Register', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => login_screen()));
        },
      ),
    );
  }

  Widget createNewAcc() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 80.0, right: 80.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0,color: Color(hexColor('#2C5364'))),
        borderRadius: BorderRadius.circular(30.0)
      ),
      child: FlatButton(
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Text('Create new account', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0),),
        onPressed: (){

        },
      ),
    );
  }

  void googleSignUp() {
    _googleSignIn.signIn(); 
    _googleSignIn.onCurrentUserChanged.listen((account) {
      if ( account != null ) Navigator.push(context, MaterialPageRoute(builder: (context) => home_screen.fromGoogle(dataFromGG: account, google: _googleSignIn,)));
    });
  }

  void googleSignOut() {
    _googleSignIn.signOut();
    setState(() {});
  }

  Widget linkedInLogin() {
    return LinkedInUserWidget(
      onGetUserProfile: (LinkedInUserModel linkedInUser){
        // print(linkedInUser);
      },
      redirectUrl: redirectUrl,
      clientId: clientId,
      clientSecret: clientSecret,
    );
  }

}
