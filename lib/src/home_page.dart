import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly'
]);

FacebookLogin facebookLogin = new FacebookLogin();

class home_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return homepageState();
  }
}

class homepageState extends State<home_page> {
  GoogleSignInAccount _account;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _account = account;
        print(_account);
      });
    });
  }

  void initiateFacebookLogin() async {
    final result = await facebookLogin.logInWithReadPermissions(['email', 'public_profile']);
    final token = result.accessToken.token;
    final graphResponse = await http.get(
      'https://graph.facebook.com/v2.12/me?fields=birthday,email&access_token=$token');  
    print(graphResponse.body);
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
    return DefaultTabController(
      length: 4,
      child: Theme(
        data: ThemeData(brightness: Brightness.dark),
        child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text("Google Sign Up"),
            ),
          ),
          body: Center(
            child: _account == null
                ? 
                // googleButton()
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    facebookButton(),
                    googleButton()
                  ],
                )
                : Row (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                    ),
                    CircularProfileAvatar(
                      _account.photoUrl,
                      radius: 50.0,
                      borderWidth: 5,
                      borderColor: Colors.white,
                    ),
                    Container(margin: EdgeInsets.only(left: 20.0)),
                    Column(
                      children: <Widget>[
                        Text(_account.displayName),
                        Text(_account.email)
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                    googleButton()
                  ],
                ),
          ),
          bottomNavigationBar: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.home,
                ),
                text: "Home",
              ),
              Tab(icon: Icon(Icons.search), text: "Search"),
              Tab(
                icon: Icon(Icons.file_download),
                text: "Downloads",
              ),
              Tab(
                icon: Icon(Icons.list),
                text: "More",
              )
            ],
            unselectedLabelColor: Color(0xff999999),
            labelColor: Colors.white,
            indicatorColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget googleButton() {
    if (_account == null) {
      return GoogleSignInButton(
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
        initiateFacebookLogin();
      },
    );
  }

  Widget circularProgress() {
    return CircularProgressIndicator();
  }

  void googleSignUp() {
    print("Hello world");
    _googleSignIn.signIn();
  }

  void googleSignOut() {
    _googleSignIn.signOut();
  }

  Future<void> facebookSignOut() async{
    var channel = MethodChannel('com.roughike/flutter_facebook_login');
    channel.invokeMethod('logOut');
  }
}
