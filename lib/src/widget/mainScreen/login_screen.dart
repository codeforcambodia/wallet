import 'package:Wallet_Apps/src/provider/hexaColorConvert.dart';
import 'package:Wallet_Apps/src/widget/homeScreen/profile_screen.dart';
import 'package:Wallet_Apps/src/widget/homeScreen/setting_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';
import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../homeScreen/home_screen.dart';
import '../../model/model.dart';
import '../../mixin/validator_mixin.dart';
import '../../bloc/bloc.dart';
import '../../provider/provider.dart';
import '../../provider/small_data/data_storage.dart';
import '../../graphql_service/query_service.dart';
import '../../provider/provider_widget.dart';
import '../forgotPassword/forgot_password.dart';
import '../../provider/check_connection.dart';

class login_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return loginState();
  }
}

class loginState extends State<login_screen> with ValidatorMixin {
  final String directory = "userID";

  bool isProgress = false;

  final formkey = GlobalKey<FormState>();

  //User login
  final FocusNode first_node = FocusNode();
  final FocusNode second_node = FocusNode();
  TextEditingController userlogin = TextEditingController();
  TextEditingController userpasswords = TextEditingController();

  //User signUp
  final FocusNode fullnameNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode conFirmPasswordNode = FocusNode();

  QueryResult queryResult = QueryResult();

  Widget build(BuildContext context) {
    Bloc bloc = Bloc();
    QueryResult result;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: bodyWidget(bloc, result, context)
      // Query(
      //   options: QueryOptions(document: user_login_data),
      //   builder: (QueryResult result, {VoidCallback refetch}){
      //     // if (result.data != null) {
      //     //   isProgress = false;
      //     //   return CircularProgressIndicator();
      //     // }
      //     return
      //   },
      // ),
    );
  }

  //body widget
  Widget bodyWidget(Bloc bloc, QueryResult result, BuildContext context) {
    return Stack(
      children: <Widget>[
        background(),
        Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: 50.0),
              child: Column(
                children: <Widget>[
                  //Image logo
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    iconTheme: IconThemeData(color: Colors.white70),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 50.0),
                    child: Center(
                      child: logoImage(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                    child: user_login(bloc, result, context),
                  ),
                  //Field input
                  // Container( margin: EdgeInsets.only(bottom: 50.0), ),
                ],
              ),
            ),
          ),
        ),
        isProgress == true ? progress() : Container(),
      ],
    );
  }

  //Below is User Login
  Widget user_login(Bloc bloc, QueryResult result, BuildContext context) {
    return Column(
      children: <Widget>[
        Container(margin: EdgeInsets.only(bottom: 25.0), child: emailField(bloc)),
        Container(margin: EdgeInsets.only(bottom: 30.0), child: passwordField(bloc)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            loginButton(bloc),
            Container(
              margin: EdgeInsets.all(15.0),
              child: forgotPassword(),
            )
          ],
        ),
      ],
    );
  }

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (context, snapshot) {
        return TextField(
          controller: userlogin,
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w300),
          textInputAction: TextInputAction.next,
          focusNode: first_node,
          keyboardType: TextInputType.emailAddress,
          onChanged: (userInput) {
            if ( userInput == null ) print('email null');
            bloc.addEmail(userInput);
          },
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(top: 23.0, bottom: 23.0, left: 20.0),
            errorText: snapshot.hasError ? snapshot.error : null,
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.white30),
            enabledBorder: outlineInput(Colors.white30),
            hintStyle: TextStyle(wordSpacing: 50.0),
            focusedBorder: outlineInput(Colors.blueAccent),
          ),
          onSubmitted: (value) {
            first_node.unfocus();
            FocusScope.of(context).requestFocus(second_node);
          },
        );
      },
    );
  }

  Widget passwordField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (context, snapshot) {
        return TextField(
          controller: userpasswords,
          style: TextStyle(color: Colors.white70),
          focusNode: second_node,
          obscureText: true,
          onChanged: (value) {
            if(value == null ) print('Password null');
            bloc.addPassword(value);
          },
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(top: 23.0, bottom: 23.0, left: 20.0),
              errorText: snapshot.hasError ? snapshot.error : null,
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.white30),
              enabledBorder: outlineInput(Colors.white30),
              focusedBorder: outlineInput(Colors.blueAccent)),
          onSubmitted: (value) {},
        );
      },
    );
  }

  Widget loginButton(bloc) {
    return StreamBuilder(
      stream: bloc.submit,
      builder: (context, snapshot) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 35.0, right: 35.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              gradient: LinearGradient(colors: [
                Color(hexColor('#f46b45')),
                Color(hexColor('#eea849'))
              ])),
          child: FlatButton(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            textColor: Colors.white70,
            child: Text(
              'Login',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18.0),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: snapshot.data == null ? null : () {
              setState(() =>isProgress = true );
              checkConnection(context).then((isConnect){
                if ( isConnect == true ) {
                  validator_login(bloc, context);
                } else {
                  setState(() {
                    isProgress = false;
                    no_internet(context);
                  });
                }
              });
            }
          ),
        );
      },
    );
  }

  Widget forgotPassword() {
    return FlatButton(
      textColor: Colors.white54,
      child: Text('Forgot password?',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400)),
      onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => forgot_password()));
      },
    );
  }

  validator_login(Bloc bloc, BuildContext context) async{
    await bloc.submitMethod(context).then((data) {
      setState(() { isProgress = false; });
      if (data == true) {
        print('success !');
        Navigator.push(context, MaterialPageRoute( builder: (context) => profile()));
      }
    }).catchError((onError){
      setState(() => isProgress = false );
    });

    // Reset User Input
    userlogin.clear(); userpasswords.clear();
    bloc.addEmail(null); bloc.addPassword(null);
  }
}
