import 'package:Wallet_Apps/src/provider/hexaColorConvert.dart';
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
import '../../provider/Data_Store/data_storage.dart';
import '../../query_service/query_service.dart';
import './background.dart';

class login_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return loginState();
  }
}

class loginState extends State<login_screen> with ValidatorMixin {

  final String directory = "userID";

  bool showLogin = false, isProgress = false;

  final formkey = GlobalKey<FormState>();

  //User login
  final FocusNode first_node = FocusNode();
  final FocusNode second_node = FocusNode();

  //User signUp
  final FocusNode fullnameNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode conFirmPasswordNode = FocusNode();

  QueryResult queryResult = QueryResult();

  @override
  void initState(){
    super.initState();
  }
  
  Widget build(BuildContext context) {

    Bloc bloc = Provider.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Query(
        options: QueryOptions(document: user_login_data),
        builder: (QueryResult result, {VoidCallback refetch}){
          if (result.data != null) {
            isProgress = false;
          }
          return bodyWidget(bloc, result);
        },
      ),
    );   
  }
  
  //body widget
  Widget bodyWidget(Bloc bloc, QueryResult result) {
    return Stack(
      children: <Widget>[
        // Background Image
        background(),
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white70),
        ),
        Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  //Image logo
                  logoImage(),
                  Row(children: <Widget>[Text('')],),
                  //Field input
                  showLogin == false ? user_login(bloc, result) : user_signup(bloc),
                  // Container( margin: EdgeInsets.only(bottom: 50.0), ),
                ],
              ),
            ),
          ),
        ),
        // isProgress == true ? loading() : Container()
      ],
    );
  }

  //Below is User Login
  Widget user_login(Bloc bloc, QueryResult result) {
    return Column(
      children: <Widget>[
        emailField(bloc),
        Row(children: <Widget>[Text('')],),
        passwordField(bloc),
        Row(children: <Widget>[Text('')],),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            loginButton(bloc, result),
            switchForm(),
          ],
        ),
        forgotPassword()
      ],
    );
  }
  
  Widget emailField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (context, snapshot){
        return TextField(
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w300),
          textInputAction: TextInputAction.next,
          focusNode: first_node,
          keyboardType: TextInputType.emailAddress,
          onChanged: (userInput) {
            bloc.addEmail(userInput);
          },
          decoration: InputDecoration(
            errorText: snapshot.hasError ? snapshot.error : null,
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.white70),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white30),
              borderRadius: BorderRadius.circular(30.0)),
            hintStyle: TextStyle(wordSpacing: 50.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(color: Colors.blueAccent)
            ),
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
      builder: (context, snapshot){
        return TextField(
          style: TextStyle(color: Colors.white70),
          focusNode: second_node,
          obscureText: true,
          onChanged: (value) {
            bloc.addPassword(value);
          },
          decoration: InputDecoration(
            errorText: snapshot.hasError ? snapshot.error : null,
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.white30),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(color: Colors.white30)
            )
          ),
          onSubmitted: (value) {
          },
        );
      },
    );
  }

  Widget loginButton(bloc, QueryResult result) {
    return StreamBuilder(
      stream: bloc.submit,
      builder: (context, snapshot){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
              colors: [
                Color(hexColor('#f46b45')),
                Color(hexColor('#eea849'))
              ]
            )
          ),
          child: FlatButton(
            padding: EdgeInsets.only(left: 60.0, right: 60.0, top: 15.0, bottom: 15.0),
            textColor: Colors.white70,
            child: Text('Log In', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0),),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            onPressed: 
            () {
              validator(bloc, result);
            },
          ),
        );
      },
    );
  }

  //Below is User Sign Up
  Widget user_signup(Bloc bloc) {
    return Column(
      children: <Widget>[
        // username(bloc),
        Row(children: <Widget>[Text('')],),
        TextField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          focusNode: emailNode,
          onChanged: (term) {
            emailNode.unfocus();
            FocusScope.of(context).requestFocus(passwordNode);
          },
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white30),
            labelText: 'Email',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white30),
              borderRadius: BorderRadius.circular(30.0)
            )
          ),
        ),
        Row(children: <Widget>[Text('')],),
        //Button
        signUpButton(),
        switchForm(),
      ],
    );
  }

  Widget username(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.username,
      builder: (context, snapshot){
        return TextField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          focusNode: fullnameNode,
          decoration: InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0))
          ),
          onSubmitted: (term) {
            fullnameNode.unfocus();
            FocusScope.of(context).requestFocus(emailNode);
          },
        );
      },
    );
  }

  Widget signUpButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        gradient: LinearGradient(
          colors: [
            Color(hexColor('#f46b45')),
            Color(hexColor('#eea849'))
          ]
        )
      ),
      child: FlatButton(
        padding: EdgeInsets.only(left: 60.0, right: 60.0, top: 15.0, bottom: 15.0),
        textColor: Colors.white,
        child: Text('Sign Up', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed: () {
          Map<String, dynamic> userdata = {
            'firstName': 'Daveat',
            'lastName': 'Corn',
            'email': 'condaveat@gmail.com',
            'password': '12345',
            'confirm_pass': '12345',
            'image': 'https://firebasestorage.googleapis.com/v0/b/flutter-236705.appspot.com/o/17499428_1876523952588037_4176834688564950044_n.jpg?alt=media&token=f335c859-e7ab-4670-9ae4-b2a3dcab92a6'
          };

          final model = User_Data.userSignUp(userdata);
          Navigator.push(context, MaterialPageRoute(builder: (context) => home_screen.fromSignUp(model)));
        },
      ),
    );
  }

  Widget switchForm() {
    return FlatButton(
      textColor: Colors.cyanAccent[700],
      child: Text('${showLogin == false ? "Sign up" : 'Already have account'}', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0)),
      onPressed: () {
        setState(() {
          if (showLogin == false)
            showLogin = true;
          else
            showLogin = false;
        });
      },
    );
  }

  Widget forgotPassword() {
    return FlatButton(
      textColor: Colors.white54,
      child: Text('Forgot password?'),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => forgotPassword()));
      },
    );
  }

  Widget loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void validator(Bloc bloc, QueryResult result) {
    if ( result.data == null ) {
      setState(() {
        isProgress = true;
      });
    } else {
      final id = bloc.submitMethod(result);
      setState(() {
        setUserID(id, directory);
        isProgress = true;
        Timer(Duration(seconds: 2), (){
          setState(()=> isProgress = false);
          Navigator.push(context, MaterialPageRoute(builder: (context) => home_screen()));
        });
      });
    }
  }

}
