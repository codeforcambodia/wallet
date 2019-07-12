import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './home_screen.dart';
import './profile_screen.dart';
import './setting_widget.dart';
import '../../provider/hexaColorConvert.dart';
import '../../provider/provider_widget.dart';
import '../../provider/small_data/data_storage.dart';

class drawerOnly extends StatelessWidget{

  Function fn;
  HttpLink _link = HttpLink(uri: "https://api.zeetomic.com/gql");

  drawerOnly(this.fn);
  
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData('userToken'),
      builder: (context, snapshot){
        return GraphQLProvider(
          client: myGrapQl(snapshot),
          child: Drawer(
            child: Column(
              children: <Widget>[
                //Header of drawer
                DrawerHeader(
                  decoration: homeBackground(),
                  margin: EdgeInsets.all(0.0),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        minRadius: 50.0,
                        maxRadius: 50.0,
                        backgroundImage: AssetImage('assets/avatar.png')
                        // widget.dataFromGG != null ? NetworkImage(widget.dataFromGG.photoUrl) : ,
                      ),
                      Container( margin: EdgeInsets.only(bottom: 10.0),),
                      // Text('${widget.dataFromGG != null ? widget.dataFromGG.displayName : 'User name'}')
                    ],
                  ),
                ),

                //Expand listview
                Expanded(
                  child: Container(
                    decoration: homeBackground(),
                    child: ListView(
                      children: <Widget>[
                        //Body of drawer
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 20.0),
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.home, color: Colors.white,),
                              Container(
                                margin: EdgeInsets.only(right: 10.0),
                              ),
                              Text('Home', style: TextStyle(color: Colors.white),)
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> home_screen()));
                          },
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 20.0),
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.account_circle, color: Colors.white),
                              Container(
                                margin: EdgeInsets.only(right: 10.0),
                              ),
                              Text('Profile', style: TextStyle(color: Colors.white))
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => profile()));
                          },
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 20.0),
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.settings, color: Colors.white),
                              Container(
                                margin: EdgeInsets.only(right: 10.0),
                              ),
                              Text('Setting', style: TextStyle(color: Colors.white))
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> setting()));
                          },
                        )
                      ],
                    ),
                  ),
                ),
                signOutButton(fn),
              ],
            ),
          ),
        );
      }
    );
  }

  myGrapQl(AsyncSnapshot snapshot){
    final AuthLink authLink = AuthLink(getToken: () async => snapshot.data['TOKEN']);
    final Link link = authLink.concat(_link as Link);
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: InMemoryCache(),
      )
    );
    return client;
  }
  Widget signOutButton(Function fn) {
    return Container(
      decoration: homeBackground(),
      child: FlatButton(
        padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
        color: Color(hexColor('#ED213A')),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.exit_to_app),
            Container(
              margin: EdgeInsets.only(right: 10.0),
            ),
            Text(
              'Sign out',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18.0, color: Colors.white),
            )
          ],
        ),
        onPressed: () {
          fn();
        }
      ),
    );
  }
}
