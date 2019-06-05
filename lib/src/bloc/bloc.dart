import 'package:flutter/material.dart';
import 'dart:async';
import '../mixin/validator_mixin.dart';
import 'package:rxdart/rxdart.dart';
import '../provider/Data_Store/data_store.dart';

class Bloc with ValidatorMixin{

  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _username = BehaviorSubject<String>();

  // User login
  get emailStream => _email.stream.transform(validateEmail); 
  get passwordStream => _password.stream.transform(validatePassword);
  get submit => Observable.combineLatest2(emailStream, passwordStream, (email, password)=> true);
  
  // User sign up
  get username => _username.stream.transform(validateName);

  Function(String) get addEmail => _email.sink.add;
  Function(String) get addPassword => _password.sink.add;
  Function(String) get addUsername => _username.sink.add;

  Future<bool> submitMethod() async {
    return getData().then((data) {
      for ( int i = 0; i < data.length; i++){
        if(data['personal'][i]['email'] == _email.value && data['personal'][i]['password'] == _password.value) return true;
        else return false;
      }
    });
  }

  dispose() {
    _email.close();
    _password.close();
  }

}