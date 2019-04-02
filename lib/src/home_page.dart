import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

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

  GoogleSignInAccount _account;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account){
      setState(() {
        _account = account;
        print(_account);
      });
    });
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Theme(
        data: ThemeData(
          brightness: Brightness.dark
        ),
        child: Scaffold(
          appBar: AppBar(title: Center(child: Text("Google Sign Up"),),),
          body: Center(
            child: _account == null ? googleButton() : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(margin: EdgeInsets.only(top:20.0),),
                CircularProfileAvatar(
                  _account.photoUrl,
                  radius: 50.0,
                  borderWidth: 5,
                  borderColor: Colors.white,
                ),
                Column(children: <Widget>[
                  Text(_account.displayName),
                  Text(_account.email)
                ],
                crossAxisAlignment: CrossAxisAlignment.center,),
                googleButton()
              ],
            ),
          ),
          bottomNavigationBar: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home,), text: "Home",),
              Tab(icon: Icon(Icons.search), text: "Search"),
              Tab(icon: Icon(Icons.file_download), text: "Downloads",),
              Tab(icon: Icon(Icons.list), text: "More",)
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
    if ( _account == null ){
      return GoogleSignInButton(
        onPressed: () => googleSignUp(),
      );
    } else {
      return IconButton(
        icon: Icon(Icons.power_settings_new),
        onPressed: () => googleSignOut(),
      );
    }
  }


  void googleSignUp() {
    _googleSignIn.signIn();
  }

  void googleSignOut() {
    _googleSignIn.signOut();
  }
}