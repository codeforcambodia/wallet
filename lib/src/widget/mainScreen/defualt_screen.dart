import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:linkedin_login/linkedin_login.dart';
import 'package:uuid/uuid.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:ui';
import 'dart:convert';
import '../../model/model.dart';
import './login_screen.dart';
import './sign_up_screen.dart';
import '../homeScreen/home_screen.dart';
import '../../query_service/query_service.dart';
import '../../provider/provider.dart';
import '../../bloc/bloc.dart';
import '../../provider/hexaColorConvert.dart';
import '../../provider/provider_widget.dart';

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
          Center(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 35.0,bottom: 35.0),
                ),
                Container(
                  height: 350.0,
                  child: Center(
                    child: logoImage(),
                  )
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      login(context),
                      Container(margin: EdgeInsets.only(top: 10.0, bottom: 10.0),),
                      createNewAcc(context)
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
          // googleSignUp();
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

  Widget login(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 70.0, right: 70.0),
      decoration: BoxDecoration(
        // boxShadow: [
        //   shadow()
        // ],
        borderRadius: BorderRadius.circular(35.0,),
        gradient: LinearGradient(
          colors: [
            Color(hexColor('#cB356b')),
            Color(hexColor('##bd3f32')),
          ]
        )
      ),
      child: flatButton(login_screen(), 'Login', context)
    );
  }

  Widget createNewAcc(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 70.0, right: 70.0),
      decoration: BoxDecoration(
        // boxShadow: [
        //   shadow()
        // ],
        gradient: LinearGradient(
          colors: [
            Color(hexColor('#384A65')),
            Color(hexColor('#384A65'))
          ],
        ),
        border: Border.all(width: 2.0, color: Color(hexColor('#82939B'))),
        borderRadius: BorderRadius.circular(35.0)
      ),
      child: flatButton(sign_up(), 'Create new account', context),
    );
  }
  
  Widget flatButton(dynamic pushClass, String text, BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.only(top: 22.0, bottom: 22.0),
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
      child: Text(text, style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.w300,),),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> pushClass));
      }
    );
  }

  // void googleSignUp() {
  //   _googleSignIn.signIn(); 
  //   _googleSignIn.onCurrentUserChanged.listen((account) {
  //     if ( account != null ) Navigator.push(context, MaterialPageRoute(builder: (context) => home_screen.fromGoogle(dataFromGG: account, google: _googleSignIn,)));
  //   });
  // }

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
