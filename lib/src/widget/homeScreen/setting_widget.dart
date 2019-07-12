import 'package:Wallet_Apps/src/provider/small_data/data_storage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class setting extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return setting_state();
  }
}

class setting_state extends State<setting>{
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setting')),
      body: FutureBuilder(
        future: fetchData('userToken'),
        builder: (context, snapshot){
          String query  = """
            query{
              queryUserById(id: "${ snapshot.data != null ? snapshot.data['id'] : ''}"){
                id
              }
            }
          """;
          return snapshot.data == null  
          ? CircularProgressIndicator() 
          : Query(
            options: QueryOptions(document: query),
            builder: (QueryResult result, {VoidCallback refetch}){
              if (result.data != null )print(result.data);
              return CircularProgressIndicator();
              // return Center(
              //   child: new Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       new Text('setting'),
              //       new RaisedButton(
              //         child: Text('Sign out'),
              //         onPressed: () {},
              //       )
              //     ],
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}