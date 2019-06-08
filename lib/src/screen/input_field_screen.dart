import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';
import './homeScreen/home_screen.dart';
import '../model/model.dart';
import '../mixin/validator_mixin.dart';
import '../screen/forgot_password/forgot_password.dart';
import '../bloc/bloc.dart';
import 'dart:async';
import '../provider/provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../provider/Data_Store/data_store.dart';


class fill_field extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return fieldState();
  }
}

class fieldState extends State<fill_field> with ValidatorMixin {
  bool showLogin = false;
  bool isProgress = false;

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
      resizeToAvoidBottomPadding: false,
      body: bodyWidget(bloc),
    );   
  }
  
  //body widget
  Widget bodyWidget(Bloc bloc) {
    return Stack(
      children: <Widget>[
        // Background Image
        // Container(
        //   decoration: BoxDecoration(
        //       image: DecorationImage(
        //     image: AssetImage('assets/blur.jpg'),
        //     fit: BoxFit.cover,
        //   )),
        //   child: BackdropFilter(
        //     filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        //     child: Container(
        //       decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
        //     ),
        //   ),
        // ),
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.blueAccent),
        ),
        Container(
          constraints: BoxConstraints.expand(),
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Image logo
              Image.asset('assets/abstract_logo_vector.png',width: 300.0,height: 200.0,),
              Row(children: <Widget>[Text('')],),
              //Field input
              showLogin == false ? user_login(bloc) : user_signup(bloc),
              // Container( margin: EdgeInsets.only(bottom: 50.0), ),
            ],
          ),
        ),
        isProgress == true ? loading() : Row()
      ],
    );
  }

  //Below is User Login
  Widget user_login(Bloc bloc) {
    return Column(
      children: <Widget>[
        emailField(bloc),
        Row(children: <Widget>[Text('')],),
        passwordField(bloc),
        Row(children: <Widget>[Text('')],),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            loginButton(bloc),
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
          textInputAction: TextInputAction.next,
          focusNode: first_node,
          keyboardType: TextInputType.emailAddress,
          onChanged: (userInput) {
            bloc.addEmail(userInput);
          },
          decoration: InputDecoration(
            errorText: snapshot.hasError ? snapshot.error : null,
            labelText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0)),
            hintStyle: TextStyle(wordSpacing: 50.0)),
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
          focusNode: second_node,
          obscureText: true,
          onChanged: (value) {
            bloc.addPassword(value);
          },
          decoration: InputDecoration(
            errorText: snapshot.hasError ? snapshot.error : null,
            labelText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0)
            )
          ),
          onSubmitted: (value) {
          },
        );
      },
    );
  }

  Widget loginButton(bloc) {
    return StreamBuilder(
      stream: bloc.submit,
      builder: (context, snapshot){
        return RaisedButton(
          padding: EdgeInsets.only(left: 60.0, right: 60.0),
          color: Colors.amber,
          textColor: Colors.white,
          child: Text('Log In'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: 
          () {
            setState(() {
              isProgress = true;
              Timer(Duration(seconds: 3), ()=> setState(()=> isProgress = false));
            });
            // bloc.submitMethod().then((data){
            //   if (data == true) Navigator.push(context, MaterialPageRoute(builder: (context)=> home_screen()));
            // });
            // if ( == true) {
            //   print ('Hello ');
            // }
            // print(validate);
          }
          ,
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
        TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          focusNode: emailNode,
          onFieldSubmitted: (term) {
            emailNode.unfocus();
            FocusScope.of(context).requestFocus(passwordNode);
          },
          decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0))),
        ),
        Row(children: <Widget>[Text('')],),
        TextFormField(
          textInputAction: TextInputAction.next,
          obscureText: true,
          focusNode: passwordNode,
          onFieldSubmitted: (term) {
            passwordNode.unfocus();
            FocusScope.of(context).requestFocus(conFirmPasswordNode);
          },
          decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0))),
        ),
        Row(children: <Widget>[Text('')],),
        TextFormField(
          validator: (value) {
            if (value == '') {
              return 'Fill password';
            } else if (value.length < 4)
              return 'Password must be 5digit';
            // else if (value != password.toString())
            //   return 'Invalid password';
            // else
              return null;
          },
          obscureText: true,
          focusNode: conFirmPasswordNode,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            labelText: 'Comfirm password',
            border: OutlineInputBorder(
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
    return RaisedButton(
      padding: EdgeInsets.only(left: 60.0, right: 60.0),
      color: Colors.amber,
      textColor: Colors.white,
      child: Text('Sign Un'),
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
    );
  }

  Widget switchForm() {
    return FlatButton(
      textColor: Colors.cyanAccent[700],
      child: Text('${showLogin == false ? "Sign up" : 'Already have account'}'),
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
      textColor: Colors.black,
      child: Text('Forgot password?'),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => forgotPassword()));
      },
    );
  }

  Widget loading() {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
        CircularProgressIndicator()
      ],)
    );
  }

}
