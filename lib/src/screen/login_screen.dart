import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../model/model.dart';
import './input_field_screen.dart';
import 'dart:ui';
import './home_screen.dart';
import 'dart:convert';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly'
]);


var getStatus;

class login_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return loginState();
  }
}

class loginState extends State<login_screen> {
  var user_data;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        // user_data = User_Data.fromGoogle(account.displayName, account.email, account.id,
        //   account.photoUrl, "");
        // print(user_data);
      });
    });
    print('Hello startup');
  }

  Future initiateFacebookLogin() async {

    FacebookLogin facebookLogin = new FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final result = await facebookLogin.logInWithReadPermissions(['email']);
    final token = result.accessToken.token;
    final graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
    switch (result.status) {
      
      case FacebookLoginStatus.error:
        print("Error");
        // onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");

        // onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        // onLoginStatusChanged(true);
        break;
    }
    final convert = jsonDecode(graphResponse.body);
    return User_Data.fromFB(convert);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
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
                  googleButton(),
                  facebookButton(),
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
        onPressed: () => googleSignUp(),
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

  Widget facebookButton() {
    return FacebookSignInButton(
      onPressed: () {
        facebookLogin();
      },
    );
  }

  Widget circularProgress() {
    return CircularProgressIndicator();
  }

  Widget createNewAcc(context) {
    return RaisedButton(
      color: Colors.white,
      child: Text('Login with account'),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => fill_field()));
      },
    );
  }

  void googleSignUp() {
    print("Hello world");
    _googleSignIn.signIn();
  }

  void googleSignOut() {
    _googleSignIn.signOut();
    setState(() {});
  }

  void facebookLogin() {
    initiateFacebookLogin().then((onValue){
      print(onValue.id);
    });
  }

  Future<void> facebookSignOut() async {
    var channel = MethodChannel('com.roughike/flutter_facebook_login');
    channel.invokeMethod('logOut');
  }
}
