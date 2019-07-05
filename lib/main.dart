import 'package:Wallet_Apps/src/Widget/mainScreen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import './src/widget/mainScreen/defualt_screen.dart';
import './src/widget/homeScreen/home_screen.dart';
import './src/widget/mainScreen/login_screen.dart';
import './src/provider/provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/rendering.dart';
import 'src/widget/restapi.dart';

void main () {
  // debugPaintSizeEnabled = true;
  runApp(App());
}

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // final HttpLink _httpLink = HttpLink(uri: 'https://hasura-flutter.herokuapp.com/v1/graphql');
    // final ValueNotifier<GraphQLClient> client = ValueNotifier(
    //   GraphQLClient(
    //     link: _httpLink as Link,
    //     cache: OptimisticCache(
    //       dataIdFromObject: typenameDataIdFromObject,
    //     )
    //   )
    // );
    // return GraphQLProvider(
    //   client: client,
    //   child: CacheProvider(
    //     child: Provider(
    //       child: 
    //     ),
    //   ),
    // );
    return Provider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: home_screen()
      )
    );
  }
}