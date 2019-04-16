import 'package:flutter/material.dart';
import 'dart:async';

class home_screen extends StatefulWidget{
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
    return DefaultTabController(
      length: 3,
      child: Theme(
        data: ThemeData(brightness: Brightness.dark),
        child: Scaffold(
          key: _scaffoldKey,
          drawer: new Drawer(
            child: ListView(
              children: <Widget>[
                new DrawerHeader(
                  child: Text('Hello '),
                )
              ],
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Hello PichTa"),
                signOutButton(),
                progess == true ? CircularProgressIndicator() : Row()
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
        setState(() {
          progess = true;
          Timer(
            Duration(seconds: 3),
            () => Navigator.of(context).pop()
          );
        });
      },
    );
  }
}