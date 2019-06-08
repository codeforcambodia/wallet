import 'package:flutter/material.dart';
import 'dart:async';
import '../profile_screen.dart';
import '../../model/model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedin_login/linkedin_login.dart';
import './body/border_row.dart';

class home_screen extends StatefulWidget{

  // final User_Data data;
  GoogleSignInAccount dataFromGG;
  GoogleSignIn google;
  LinkedInUserModel userModel;
  User_Data dataSignUp;

  home_screen.fromGoogle({Key key, this.dataFromGG, this.google}) {
    print(dataFromGG);
  }
  home_screen.fromLinkedIn({Key key, this.userModel}){
    print(userModel);
  }

  home_screen.fromSignUp(this.dataSignUp){
    print(dataSignUp.firstName);
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
  final border = CardUser();

  //Widget Build
  Widget build(BuildContext context) {  
    return new Theme(
      data: new ThemeData(brightness: Brightness.dark),
      child: new Scaffold(
        key: _scaffoldKey,
        drawer: drawerWidget(),
        body: bodyWidget(),
      ),
    );
  }

  //Widget function
  
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
                  contentPadding: EdgeInsets.only(left: 20.0),
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.settings),
                      Container(margin: EdgeInsets.only(right: 10.0),),
                      Text('Setting')
                    ],
                  ),
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
    return Container(
      color: Colors.red,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 280.0,
            padding: EdgeInsets.all(10.0),
            color: Colors.black,
            child: Stack(
              children: <Widget>[
                Image(height: double.infinity, width: double.infinity ,image: NetworkImage('https://www.w3schools.com/w3css/img_lights.jpg'),),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text("Daveat",style: TextStyle(fontSize: 25.0,)),
                  ),
                ),
                appbarWidget()
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5.0),
              color: Colors.blue,
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, int index){
                  return Card(child: RaisedButton(onPressed: (){},child: Text('Hello'),));
                },
              ),
            ),
          ),
        ],
      )
    );
  }

  void _singOut(){
    if(widget.google != null) widget.google.signOut();
    setState(() {
      progess = true;
    });
    new Timer(Duration(seconds: 2), (){
      setState(() {
        progess = false;
      });
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
    });
  }

}