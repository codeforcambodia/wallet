import 'package:Wallet_Apps/src/query_service/query_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../profile_screen.dart';
import '../../model/model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedin_login/linkedin_login.dart';
import './body/border_row.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../provider/Data_Store/data_storage.dart';
import '../../query_service/query_service.dart';

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
        drawer: Stack(
          children: <Widget>[
            drawerWidget(),
            progess == false ? Container() : Center(child: CircularProgressIndicator(),)
          ],
        ),
        body: FutureBuilder(
          future: fetchId('userID'),
          builder: (context, snapshot){
            return Query(
              options: QueryOptions(document: query(snapshot.data)),
              builder: (QueryResult result, {VoidCallback refetch}){
                if ( result.data == null ) return Center(
                  child: CircularProgressIndicator(),
                );
                return bodyWidget(result, totalPrice(result.data['user_data'][0]['books']));
              },
            );
          },
        ),
      ),
    );
  }

  totalPrice(List<dynamic> books) {
    int amount = 0;
    for(int i = 0; i < books.length; i++){
      amount += books[i]['price'];
    }
    return amount;
  }

  //Widget function
  Widget appbarWidget() {
    return AppBar(
      title: Image.asset('assets/zeetomic-logo-header.png', width: 100.0, height: 100.0,),
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
        ),
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
                // Text('${widget.dataFromGG != null ? widget.dataFromGG.displayName : 'User name'}')
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
  Widget bodyWidget(QueryResult result, int total) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 280.0,
            color: Colors.black,
            child: Stack(
              children: <Widget>[
                Image(height: double.infinity, width: double.infinity ,image: NetworkImage('https://www.w3schools.com/w3css/img_lights.jpg'),),
                Container(
                  margin: EdgeInsets.only(bottom: 15.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(result.data['user_data'][0]['user_name'],style: TextStyle(fontSize: 32.0,)),
                  ),
                ),
                appbarWidget()
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
            child: Center(
              child: Text('HOLDING',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w300))
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0, bottom: 15.0),
            child: Center(
              child: Text('Total ${total.toString()}.00 USD',style: TextStyle(fontSize: 20.0,)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: (result.data['user_data'][0]['books'].length),
              itemBuilder: (context, int index){
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 15.0),
                  color: Colors.orange[800],
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Container(width: 130.0,
                          child: Text(result.data['user_data'][0]['books'][index]['title'],style: TextStyle(
                            fontSize: 15.0,
                          ),),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(width: 1.0, color: Colors.black)
                            )
                          ),
                          margin: EdgeInsets.only(left: 10.0),
                          padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                          child: Column(
                            children: <Widget>[
                              Text('${result.data['user_data'][0]['books'][index]['price']} USD', style: TextStyle(color: Colors.black, fontSize: 20.0)),
                            ],
                          )
                        )
                      ],
                    ),
                  ),
                );
              },
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