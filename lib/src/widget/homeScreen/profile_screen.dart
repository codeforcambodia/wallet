import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:async';
import '../../bloc/bloc.dart';
import '../../provider/provider.dart';
import './drawer.dart';
import '../../model/model_profile.dart';
import '../../provider/small_data/data_storage.dart';
import '../../graphql_service/mutation.dart';

class profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return profile_state();
  }
}

class profile_state extends State<profile>{

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ProfileModel model = ProfileModel();
  
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawerOnly(signOut),
      appBar: AppBar(title: Text('Profile'), centerTitle: true, actions: <Widget>[
        IconButton(icon: Icon(Icons.notifications),onPressed: () {},)
      ],),
      body: Mutation(
        options: MutationOptions(document: mutation),
        builder: (RunMutation runMutation, QueryResult result){
          return bodyWidget(runMutation);
        },
        update: (Cache cache, QueryResult result){
          return cache;
        },
        onCompleted: (dynamic resultData){
          print(resultData['verifyUser']);
        },
      )
    );
  }

  Widget bodyWidget(RunMutation runMutation) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: <Widget>[
              TextField(
                textInputAction: TextInputAction.continueAction,
                decoration: InputDecoration(
                  labelText: 'First name',
                ),
                onChanged: (value){
                  model.first_name = value;
                },
              ),
              
              Container(margin: EdgeInsets.only(bottom: 20.0)),
              TextField(
                textInputAction: TextInputAction.continueAction,
                decoration: InputDecoration(
                  labelText: 'Mid name',
                ),
                onChanged: (value) {
                  model.mid_name = value;
                },
              ),

              Container(margin: EdgeInsets.only(bottom: 20.0)),
              TextField(
                textInputAction: TextInputAction.continueAction,
                decoration: InputDecoration(
                  labelText: 'Last name',
                ),
                onChanged: (value){
                  model.last_name = value;
                },
              ),

              Container(margin: EdgeInsets.only(bottom: 20.0)),
              // Row(
              //   mainAxisSize: MainAxisSize.max,
              //   children: <Widget>[
                  TextField(
                    textInputAction: TextInputAction.continueAction,
                    decoration: InputDecoration(
                      labelText: 'Document id'
                    ),
                    onChanged: (value){
                      model.document_id = value;
                    },
                  ),
                  // RaisedButton(
                  //   child: Text('Gender'),
                  //   onPressed: () => genderDialog(context),
                  // ),
              //   ],
              // ),

              Container(margin: EdgeInsets.only(bottom: 20.0)),
              TextField(
                textInputAction: TextInputAction.continueAction,
                decoration: InputDecoration(
                  labelText: 'User status'
                ),
                onChanged: (value){
                  model.user_status = value;
                },
              ),

              Container(margin: EdgeInsets.only(bottom: 20.0)),
              TextField(
                textInputAction: TextInputAction.continueAction,
                decoration: InputDecoration(
                  labelText: 'Temporary Token'
                ),
                onChanged: (value){
                  model.tempToken = value;
                },
              ),

              Container(margin: EdgeInsets.only(bottom: 20.0)),
              TextField(
                textInputAction: TextInputAction.continueAction,
                decoration: InputDecoration(
                  labelText: 'Created at',
                ),
                onChanged: (value){
                  model.create_id = value;
                },
              ),

              Container(margin: EdgeInsets.only(bottom: 20.0)),
              TextField(
                textInputAction: TextInputAction.continueAction,
                decoration: InputDecoration(
                  labelText: 'Updated at',
                ),
                onChanged: (value){
                  model.updated_id = value;
                },
              ),

              Container(margin: EdgeInsets.only(bottom: 20.0)),
              RaisedButton(
                child: Text('Save'),
                onPressed: () {
                  runMutation({
                    'email': 'user5@gmail.com',
                    'first_name': model.first_name,
                    'mid_name': model.first_name,
                    'last_name': model.last_name,
                    'gender': model.gender,
                    'wallet': model.wallet,
                    'document_id': model.document_id,
                    'user_status': model.user_status,
                    'tempToken': model.tempToken,
                    'create_id': model.create_id,
                    'updated_id': model.updated_id
                  });
                  // model.convertToJson().then((data){
                  //   print(data);
                  // });
                },
              )
            ],
          ),
        ),
      )
    );
  }

  genderDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Gender'),
          content: Radio(
            groupValue: 1,
            value: 1,
            onChanged: (value){
              print(value);
            },
          ),
        );
      }
    );
  }
  void signOut() {
    print('Hello sign out');
    // if(widget.google != null) widget.google.signOut();
    // setState(() {
    //   isProgress = true;
    // });
    Timer(Duration(seconds: 2), () {
      // setState(() {
        // isProgress = false;
      // });
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
    });
  }
}