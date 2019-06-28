import 'package:Wallet_Apps/src/query_service/query_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../model/model.dart';
import '../../provider/Data_Store/data_storage.dart';
import '../../query_service/query_service.dart';
import '../../provider/hexaColorConvert.dart';
import '../../provider/provider_widget.dart';
import './drawer.dart';

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
  bool isProgess = false;

  QueryResult result;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //Widget Build
  Widget build(BuildContext context) {  
    return new Theme(
      data: new ThemeData(brightness: Brightness.dark),
      child: new Scaffold(
        key: _scaffoldKey,
        drawer: Stack(
          children: <Widget>[
            drawerWidget(context),
            isProgess == false ? Container() : progress()
          ],
        ),
        body: Stack(
          children: <Widget>[
            background(),
            // totalPrice(result.data['user_data'][0]['books'])
            bodyWidget(result, 0)
          ],
        ) 
        // FutureBuilder(
        //   future: fetchId('userID'),
        //   builder: (context, snapshot){
        //     return Query(
        //       options: QueryOptions(document: query(snapshot.data)),
        //       builder: (QueryResult result, {VoidCallback refetch}){
        //         if ( result.data == null ) return Center(
        //           child: CircularProgressIndicator(),
        //         );
        //         return Stack(
        //           children: <Widget>[
        //             background(),
        //             bodyWidget(result, totalPrice(result.data['user_data'][0]['books']))
        //           ],
        //         );
        //       },
        //     );
        //   },
        // ),
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
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/header.jpeg'),
                      fit: BoxFit.fill
                    )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    // result.data['user_data'][0]['user_name']
                    child: Text('User name',style: TextStyle(fontSize: 32.0,)),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Total ', style: TextStyle(fontSize: 20.0)),
                  Text('$total.00 USD',style: TextStyle(fontSize: 20.0, color: Colors.orange))
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: /* (result.data['user_data'][0]['books'].length) */ 10,
              itemBuilder: (context, int index){
                return Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 15.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: Container  (
                      decoration: BoxDecoration(
                        boxShadow: [
                          shadow()
                        ],
                        borderRadius: BorderRadius.circular(5.0),
                        gradient: LinearGradient(
                          colors: [
                            Color(hexColor("#073C71")),
                            Color(hexColor("#373B44")),
                          ]
                        )
                      ),
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Flexible(
                            flex: 2,
                            child: Container(
                              // width: 100.0,
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(width: 1.0, color: Colors.black)
                                )
                              ),
                              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                                // ${result.data['user_data'][0]['books'][index]['price']}
                              child: Center(
                                child: Text('10 USD', style: TextStyle(color: Colors.orange, fontSize: 20.0)),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                              margin: EdgeInsets.only(left: 5.0),
                              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
                              // ${result.data['user_data'][0]['books'][index]['price']}
                              child: Text(' IntendedVsync=11192334779883, Vsync=11193168113183, NeweSD', style: TextStyle(color: Colors.orange, fontSize: 20.0)),
                            ),
                            ),
                          ),
                          // SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   child: Container(
                          //     margin: EdgeInsets.only(left: 10.0),
                          //     child: Text("${result.data['user_data'][0]['books'][index]['title']} hello mother fucker bitch",style: TextStyle(
                          //       fontSize: 18.0,
                          //       fontWeight: FontWeight.w300
                          //     ),),
                          //   )
                          // )
                        ],
                      ),
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

  void signOut(){
    // if(widget.google != null) widget.google.signOut();
    setState(() {
      isProgess = true;
    });
    new Timer(Duration(seconds: 2), (){
      setState(() {
        isProgess = false;
      });
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
    });
  }

}