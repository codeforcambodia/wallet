import 'package:flutter/material.dart';
import 'dart:async';
import './profile_screen.dart';
import '../model/model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedin_login/linkedin_login.dart';
import  './login_screen.dart';

class home_screen extends StatefulWidget{

  // final User_Data data;
  GoogleSignInAccount dataFromGG;
  GoogleSignIn google;
  LinkedInUserModel userModel;

  home_screen.fromGoogle({Key key, this.dataFromGG, this.google}) : super(key:key);
  home_screen.fromLinkedIn({Key key, this.userModel}){
    print('Home Screen ${userModel.firstName.localized.label}');
  }

  home_screen();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeState();
  }
}

class homeState extends State<home_screen>{

  TabController _tabController;
  bool progess = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {  
    return new Theme(
      data: new ThemeData(brightness: Brightness.dark),
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            new IconButton(
              iconSize: 35.0,
              icon: Icon(Icons.account_circle),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            )
          ],
        ),
        drawer: new Drawer(
          child: new Column(
            children: <Widget>[

              //Expand listview
              new Expanded(
                child: new ListView(
                  children: <Widget>[
                    //Header of drawer
                    new DrawerHeader(
                      child: Column(
                        children: <Widget>[
                          new CircleAvatar(
                            minRadius: 50.0,
                            maxRadius: 50.0,
                            backgroundImage: widget.dataFromGG != null ? NetworkImage(widget.dataFromGG.photoUrl) : AssetImage('assets/avatar.png'),
                            // backgroundImage: widget.dataFromGG != null ? NetworkImage(widget.dataFromGG.photoUrl) : AssetImage('assets/avatar.png'),
                          ),
                          Container(margin: EdgeInsets.only(bottom: 5.0),),
                          Text('${widget.dataFromGG != null ? widget.dataFromGG.displayName : ''}')
                        ],
                      ),
                    ),
                    //Body of drawer
                    new ListTile(
                      leading: Row(
                        children: <Widget>[
                          Container(margin: EdgeInsets.only(left: 10.0),),
                          Icon(Icons.home),
                          Container(margin: EdgeInsets.only(right: 10.0),),
                          Text('Home')
                        ],
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    new ListTile(
                      leading: Row(
                        children: <Widget>[
                          Container(margin: EdgeInsets.only(left: 10.0),),
                          Icon(Icons.account_circle),
                          Container(margin: EdgeInsets.only(right: 10.0),),
                          Text('Profile')
                        ],
                      ),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => profile_screen()));
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              signOutButton(),

              //Progressive
              progess == true ? 
              Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ) : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget signOutButton() {
    return new FlatButton(
      color: Colors.red,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.exit_to_app),
          Container(margin: EdgeInsets.only(right: 10.0),),
          Text('Sign out')
        ],
      ),
      onPressed: _singOut
    );
  }

  void _singOut(){
    setState(() {
      progess = true;
    });
    new Timer(Duration(seconds: 4), (){
      setState(() {
        progess = false;
      });
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
    });
  }

}