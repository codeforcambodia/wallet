import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../model/model.dart';
import './input_field_screen.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly'
]);

FacebookLogin facebookLogin = new FacebookLogin();

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
        user_data = User_Data(account.displayName, account.email, account.id, account.photoUrl);
        print(user_data);
      });
    });
  }

  void initiateFacebookLogin() async {
    final result = await facebookLogin.logInWithReadPermissions(['email']);
    final token = result.accessToken.token;
    final graphResponse = await http.get(
      'https://graph.facebook.com/v2.12/me?fields=email&access_token=$token');
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
  }

  Widget build(BuildContext context) {    
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left:20.0, right: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset('assets/abstract_logo_vector.png',width: 300.0, height: 200.0,),
              createNewAcc(context),
              googleButton(),
              facebookButton(),
            ],
          ),
        ),
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
        // initiateFacebookLogin();
      },
    );
  }

  Widget circularProgress() {
    return CircularProgressIndicator();
  }

  Widget createNewAcc(context) {
    return RaisedButton(
      child: Text('Create new account'),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => fill_field() ));
      },
    );
  }

  void googleSignUp() {
    print("Hello world");
    _googleSignIn.signIn();
  }

  void googleSignOut() {
    _googleSignIn.signOut();
    setState(() {
      
    });
  }

  Future<void> facebookSignOut() async{
    var channel = MethodChannel('com.roughike/flutter_facebook_login');
    channel.invokeMethod('logOut');
  }
}
