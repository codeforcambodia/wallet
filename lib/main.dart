import 'package:Wallet_Apps/src/provider/small_data/data_storage.dart';
import 'package:Wallet_Apps/src/widget/homeScreen/setting_widget.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/rendering.dart';
import 'src/widget/restapi.dart';
import './src/widget/mainScreen/defualt_screen.dart';
import './src/widget/homeScreen/home_screen.dart';
import './src/widget/mainScreen/login_screen.dart';
import './src/provider/provider.dart';
import './src/widget/homeScreen/profile_screen.dart';


void main () {
  // debugPaintSizeEnabled = true;
  runApp(App());
}

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final HttpLink _httpLink = HttpLink(uri: 'https://api.zeetomic.com/gql');
    return FutureBuilder(
      future: fetchData('userToken'),
      builder: (context, snapshot){
        final AuthLink authLink = AuthLink(getToken: () async => 'Bearer ${snapshot.data != null ? snapshot.data['TOKEN'] : ""}');
        final Link link = authLink.concat(_httpLink as Link);
        final ValueNotifier<GraphQLClient> client = ValueNotifier(
          GraphQLClient(
            link: link,
            cache: InMemoryCache()
          )
        );
        return GraphQLProvider(
          client: client,
          child: CacheProvider(
            child: Provider(
              child: MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  // is not restarted.
                  primarySwatch: Colors.blue,
                ),
                home: default_screen()
              )
            ),
          ),
        );
      },
    );
  }
}