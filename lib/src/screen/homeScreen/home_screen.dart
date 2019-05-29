import 'package:flutter/material.dart';
import 'dart:async';
import '../profile_screen.dart';
import '../../model/model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedin_login/linkedin_login.dart';

class home_screen extends StatefulWidget{

  // final User_Data data;
  GoogleSignInAccount dataFromGG;
  GoogleSignIn google;
  LinkedInUserModel userModel;

  home_screen.fromGoogle({Key key, this.dataFromGG, this.google}) {
    print(dataFromGG);
  }
  home_screen.fromLinkedIn({Key key, this.userModel}){
    print(userModel);
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

  //WIdget function
  
  Widget appbarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        new IconButton(
          iconSize: 40.0,
          icon: Icon(Icons.account_circle),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        )
      ],
    );
  }

  Widget drawerWidget(){
    return Drawer(
      child: new Column(
        children: <Widget>[
          //Header of drawer
          new DrawerHeader(
            margin: EdgeInsets.all(0.0),
            child: Column(
              children: <Widget>[
                new CircleAvatar(
                  minRadius: 50.0,
                  maxRadius: 50.0,
                  backgroundImage: widget.dataFromGG != null ? NetworkImage(widget.dataFromGG.photoUrl) : AssetImage('assets/avatar.png'),
                ),
                Container(margin: EdgeInsets.only(bottom: 10.0),),
                Text('${widget.dataFromGG != null ? widget.dataFromGG.displayName : 'User name'}')
              ],
            ),
          ),

          //Expand listview
          Expanded(
            child: ListView(
              children: <Widget>[
                //Body of drawer
                ListTile(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.home),
                      Container(margin: EdgeInsets.only(right: 10.0),),
                      Text('Home')
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.account_circle),
                      Container(margin: EdgeInsets.only(right: 10.0),),
                      Text('Profile')
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Text('Setting'),
                  onTap: () {},
                )
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

  //body widget
  Widget bodyWidget() {
    return ListView(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Text('It looks lonely in here!',style: TextStyle(fontSize: 25.0,color: Colors.white70),),
            ),
            Image.asset('assets/island.png',width: 250.0,),
            Container(margin: EdgeInsets.only(bottom: 20.0),),
            SizedBox(
              width: 200,
              child: RaisedButton(
                padding: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_circle),
                    Container(margin: EdgeInsets.only(right: 15.0),),
                    Text('Add a business', style: TextStyle(fontSize: 20.0),)
                  ],
                ),
                onPressed: () {},
              ),
            )
          ],
        )
      ]
    );
  }

  void _singOut(){
    if(widget.google != null) widget.google.signOut();
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

  //Widget Build
  Widget build(BuildContext context) {  
    return new Theme(
      data: new ThemeData(brightness: Brightness.dark),
      child: new Scaffold(
        appBar: appbarWidget(),
        key: _scaffoldKey,
        drawer: drawerWidget(),
        body: bodyWidget(),
      ),
    );
  }
}