import 'package:flutter/material.dart';

class home_screen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeState();
  }
}

class homeState extends State<home_screen>{
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
          body: Text('Hello world'),
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
}