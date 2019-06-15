import 'package:flutter/material.dart';
import 'dart:async';
import '../mixin/validator_mixin.dart';
import 'package:rxdart/rxdart.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Bloc with ValidatorMixin{

  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _username = BehaviorSubject<String>();
  
  get emailStream => _email.stream.transform(validateEmail); 
  get passwordStream => _password.stream.transform(validatePassword);
  get submit => Observable.combineLatest2(emailStream, passwordStream, (email, password)=> true);
  
  // User sign up
  get username => _username.stream.transform(validateName);

  Function(String) get addEmail => _email.sink.add;
  Function(String) get addPassword => _password.sink.add;
  Function(String) get addUsername => _username.sink.add;

  String submitMethod(QueryResult result)  {
    print(_email.value);
    print(_password.value);
    for ( int i = 0; i < result.data['user_login'].length; i++){
      if(result.data['user_login'][i]['email'] == _email.value && result.data['user_login'][i]['password'] == _password.value) return result.data['user_login'][i]['id'];
    }
  }

  dispose() {
    _email.close();
    _password.close();
  }

}