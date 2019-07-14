import 'package:Wallet_Apps/src/widget/homeScreen/profile_screen.dart';
import 'package:Wallet_Apps/src/widget/homeScreen/setting_widget.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:convert';
import '../../model/model.dart';
import '../../provider/small_data/data_storage.dart';
import '../../provider/hexaColorConvert.dart';
import '../../provider/provider_widget.dart';
import './drawer.dart';
import '../../provider/provider.dart';
import '../../bloc/bloc.dart';

class home_screen extends StatefulWidget {
  // final User_Data data;
  GoogleSignInAccount dataFromGG;
  GoogleSignIn google;
  LinkedInUserModel userModel;
  User_Data dataSignUp;

  // home_screen.fromGoogle({Key key, this.dataFromGG, this.google}) {
  //   print(dataFromGG);
  // }
  // home_screen.fromLinkedIn({Key key, this.userModel}) {
  //   print(userModel);
  // }

  home_screen();

  // home_screen.fromSignUp(this.dataSignUp) {
  //   print(dataSignUp.firstName);
  // }

  State<StatefulWidget> createState() {
    return homeState();
  }
}

class homeState extends State<home_screen> {

  TabController _tabController;
  bool isProgress = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final HttpLink _link = HttpLink(uri: "https://api.zeetomic.com/gql");

  //Widget Build
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return new Theme(
      data: new ThemeData(brightness: Brightness.dark),
      child: new Scaffold(
        key: _scaffoldKey,
        drawer: Stack(
          children: <Widget>[
            drawerOnly(signOut),
            isProgress == false ? Container() : progress()
          ],
        ),
        body: FutureBuilder(
          future: fetchData('userToken'),
          builder: (context, snapshot){
            /* Retrieve user token and id from local storage */
            String query  = """
              query{
                queryUserById(id: "${ snapshot.data != null ? snapshot.data['id'] : ''}"){
                  id
                  email
                  passwords
                }
              }
            """;
            return snapshot.data == null 
            ? Center(child: CircularProgressIndicator(),) 
            : Stack(
              children: <Widget>[
                background(),
                // totalPrice(result.data['user_data'][0]['books'])
                Query(
                  options: QueryOptions(document: query),
                  builder: (QueryResult result, {VoidCallback refetch}){
                    if (result.data != null) setData(Map<String, dynamic>.from(result.data['queryUserById']), 'userLogin');
                    return bodyWidget(result, 0, bloc);
                  },
                )
              ],
            );
          },
        )
      )
    );
  }

  totalPrice(List<dynamic> books) {
    int amount = 0;
    for (int i = 0; i < books.length; i++) {
      amount += books[i]['price'];
    }
    return amount;
  }

  //Widget function
  Widget appbarWidget(Bloc bloc) {
    return AppBar(
      centerTitle: false,
      // title: Image.asset(
      //   'assets/zeetomic-logo-header.png',
      //   width: 100.0,
      //   height: 100.0,
      // ),
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
  Widget bodyWidget(QueryResult result, int total, Bloc bloc) {
    return Container(
      child: Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 280.0,
          color: Colors.black,
          child: Stack(
            children: <Widget>[
              background(),
              Container(
                margin: EdgeInsets.only(bottom: 15.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  // result.data['user_data'][0]['user_name']
                  child: Text('User name',
                      style: TextStyle(
                        fontSize: 32.0,
                      )),
                ),
              ),
              appbarWidget(bloc),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
          child: Center(
              child: Text('HOLDING',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300))),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.0, bottom: 15.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Total ', style: TextStyle(fontSize: 20.0)),
                Text('$total.00 USD',
                    style: TextStyle(fontSize: 20.0, color: Colors.orange))
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: /* (result.data['user_data'][0]['books'].length) */ 10,
            itemBuilder: (context, int index) {
              return Container(
                margin: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 5.0, bottom: 15.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [shadow()],
                        borderRadius: BorderRadius.circular(5.0),
                        gradient: LinearGradient(colors: [
                          Color(hexColor("#073C71")),
                          Color(hexColor("#373B44")),
                        ])),
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
                                    right: BorderSide(
                                        width: 1.0, color: Colors.black))),
                            padding: EdgeInsets.only(
                                top: 10.0, bottom: 10.0, right: 10.0),
                            // ${result.data['user_data'][0]['books'][index]['price']}
                            child: Center(
                              child: Text('10 USD',
                                  style: TextStyle(
                                      color: Colors.orange, fontSize: 20.0)),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              margin: EdgeInsets.only(left: 5.0),
                              padding: EdgeInsets.only(
                                  top: 10.0, bottom: 10.0, left: 10.0),
                              // ${result.data['user_data'][0]['books'][index]['price']}
                              child: Text(
                                  ' IntendedVsync=11192334779883, Vsync=11193168113183, NeweSD',
                                  style: TextStyle(
                                      color: Colors.orange, fontSize: 20.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ));
  }

  void signOut() {
    print('Hello sign out');
    if(widget.google != null) widget.google.signOut();
    setState(() {
      isProgress = true;
    });
    Timer(Duration(seconds: 2), () {
      setState(() {
        isProgress = false;
      });
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
    });
  }

  myGrapQl(AsyncSnapshot snapshot, ){
    final AuthLink authLink = AuthLink(getToken: () async => 'Bearer ${snapshot.data['TOKEN']}');
    final Link link = authLink.concat(_link as Link);
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: InMemoryCache(),
      )
    );
    return client;
  }

  void saveUserLogin(QueryResult result) {
    if (result.data != null) setData(result.data, 'userLogin');
  }
}
