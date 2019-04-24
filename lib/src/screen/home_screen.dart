import 'package:flutter/material.dart';
import 'dart:async';
import './profile_screen.dart';
import '../model/model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class home_screen extends StatefulWidget{

  // final User_Data data;
  var dataFromFB;
  var dataFromGG;

  GoogleSignIn google;

  home_screen.fromFacebook({Key key, this.dataFromFB}) : super(key:key);
  home_screen.fromGoogle({Key key, this.dataFromGG, this.google}) : super(key:key);
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

  Widget _status(dataFb, dataGG) {
    if ( dataFb != null ) {
      return Text('Facebook ${dataFb.name}');
    } else if (dataGG != null){
      return Text('Google ${dataGG.displayName}');
    } else {
      return Text('Null');
    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Theme(
        data: ThemeData(brightness: Brightness.dark),
        child: Scaffold(
          key: _scaffoldKey,
          drawer: new Drawer(
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
                      ),
                      Container(margin: EdgeInsets.only(bottom: 5.0),),
                      _status(widget.dataFromFB, widget.dataFromGG)
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
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Hello page 1'),
                    signOutButton()
                  ],
                ),
              ),
              profile_screen(),
            ],
            
          ),
          bottomNavigationBar: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.home,
                ),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.account_circle),
                text: "Profile",
              ),
              Tab(
                icon: Icon(Icons.menu),
                text: "Menu",
              ),
            ],
            onTap: (index) {
              if ( index == 2) _scaffoldKey.currentState.openDrawer();
            },
            unselectedLabelColor: Color(0xff999999),
            labelColor: Colors.white,
            indicatorColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget signOutButton() {
    return RaisedButton(
      child: Text('Sign Out'),
      onPressed: () {
        if ( widget.dataFromFB != null) {
          print('facebook login');
          FacebookLogin.channel.invokeMethod('logOut');
        } else {
          widget.google.signOut();
        }
        Navigator.of(context).pop();
        setState(() {
          // progess = true;
          // Timer(
          //   Duration(seconds: 3),
          //   () => Navigator.of(context).pop()
          // );
        });
      },
    );
  }



}