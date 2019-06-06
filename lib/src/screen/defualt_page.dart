import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../model/model.dart';
import './input_field_screen.dart';
import 'dart:ui';
import './homeScreen/home_screen.dart';
import 'dart:convert';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:uuid/uuid.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../provider/Data_Store/data_store.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly'
]);

class login_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return loginState();
  }
}

class loginState extends State<login_screen> {
  GoogleSignInAccount user_data;
  
  final String redirectUrl = "https://testnet.zeetomic.com";
  final String clientId = '81l6052tuwhceq';
  final String clientSecret = 'P8T0FNCQJfQ3ArLq';

  final String query = """
    query {
      personal {
        email
        password
        id
      }
    }
  """;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
        options: QueryOptions(document: query),
        builder: (QueryResult result, {VoidCallback refetch}){
          if ( result.data != null ) {
            setData(result.data);
          }
          return Stack(
            children: <Widget>[
              new Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/blur.jpg'),
                    fit: BoxFit.cover,
                )),
                child: BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Image.asset(
                        'assets/abstract_logo_vector.png',
                        width: 300.0,
                        height: 200.0,
                      ),
                      new Row(  
                        children: <Widget>[Text('')],
                      ),
                      new Row(
                        children: <Widget>[Text('')],
                      ),
                      createNewAcc(context),
                      Container(margin: EdgeInsets.only(bottom: 5),),
                      linkedInButton(),
                      Container(margin: EdgeInsets.only(bottom: 5),),
                      googleButton(),
                      Container(margin: EdgeInsets.only(bottom: 50.0),),
                    ],
                  ),
                ),
              )
            ],
          );
        },
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

  Widget createNewAcc(context) {
    return RaisedButton(
      color: Colors.white,
      child: Text('Login & Register'),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => fill_field()));
      },
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
