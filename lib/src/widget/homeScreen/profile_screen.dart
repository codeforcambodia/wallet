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
      body: FutureBuilder(
        future: fetchData('userLogin'),
        builder: (context, snapshot){
          /* Retrieve user login data from local storage */
          return snapshot.data == null 
          ? CircularProgressIndicator() 
          : Mutation(
            options: MutationOptions(document: mutation),
            builder: (RunMutation runMutation, QueryResult result){
              return bodyWidget(runMutation, snapshot.data);
            },
            update: (Cache cache, QueryResult result){
              return cache;
            },
            onCompleted: (dynamic resultData){
              print(resultData);
            },
          );
        },
      )
    );
  }

  Widget bodyWidget(RunMutation runMutation, Map<String, dynamic> data) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'First name',
                ),
                onChanged: (value){
                  model.first_name = value;
                  validator_profile_user();
                },
              ),
              
              Container(margin: EdgeInsets.only(bottom: 20.0)),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Mid name',
                ),
                onChanged: (value) {
                  model.mid_name = value;
                  validator_profile_user();
                },
              ),

              Container(margin: EdgeInsets.only(bottom: 20.0)),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Last name',
                ),
                onChanged: (value){
                  model.last_name = value;
                  validator_profile_user();
                },
              ),

              Container(margin: EdgeInsets.only(bottom: 20.0)),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(flex: 2, child: 
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Gender'
                      ),
                      onChanged: (value){
                        model.gender = value;
                        validator_profile_user();
                      },
                    ),
                  ),
                  Expanded(child: Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: RaisedButton(
                      child: Text('Gender'),
                      onPressed: () => genderDialog(context),
                    ),
                  ),)
                ],
              ),

              Container(margin: EdgeInsets.only(bottom: 20.0),),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Document id'
                ),
                onChanged: (value){
                  model.document_id = value;
                  validator_profile_user();
                },
              ),

              Container(margin: EdgeInsets.only(bottom: 20.0)),
              TextField(
                decoration: InputDecoration(
                  labelText: 'User status'
                ),
                onChanged: (value){
                  model.user_status = value;
                  validator_profile_user();
                },
              ),

              Container(margin: EdgeInsets.only(bottom: 20.0)),
              FutureBuilder(
                future: validator_profile_user(),
                builder: (context, snapshot){
                  return RaisedButton(
                    child: Text('Save'),
                    onPressed: snapshot.data == true ? () {
                      runMutation({
                        'emails': data['email'],
                        'first_names': model.first_name,
                        'mid_names': model.mid_name,
                        'last_names': model.last_name,
                        'genders': model.gender,
                        'document_ids': model.document_id,
                        'user_statuses': model.user_status,
                      });
                      // model.convertToJson().then((data){
                      //   print(data);
                      // });
                    } : null,
                  );
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

  /* Validate user profile input */
  Future<bool> validator_profile_user() async {
    if ( 
      model.first_name != null && model.first_name != "" &&
      model.mid_name != null && model.mid_name != "" &&
      model.last_name != null && model.last_name != "" &&
      model.gender != null && model.gender != "" &&
      model.document_id != null && model.document_id != "" &&
      model.user_status != null && model.user_status != ""
    ) return true;
    return false;
  }
}