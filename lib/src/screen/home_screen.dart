import 'package:flutter/material.dart';
import 'dart:async';
import './profile_screen.dart';

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
                //Header of drawer
                DrawerHeader(
                  child: Column(
                    children: <Widget>[
                      new CircleAvatar(
                        minRadius: 50.0,
                        maxRadius: 50.0,
                        backgroundImage: AssetImage('assets/abstract_logo_vector.png'),
                      ),
                      Container(margin: EdgeInsets.only(bottom: 5.0),),
                      Text('Daveat Corn'),
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
                  onTap: () {},
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
                  onTap: () {},
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Center(
                child: Text('Hello page 1'),
              ),
              profile_screen()
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