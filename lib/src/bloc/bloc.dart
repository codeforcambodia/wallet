import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../mixin/validator_mixin.dart';
import '../rest_data/rest_api.dart';
import '../provider/provider_widget.dart';

class Bloc with ValidatorMixin{

  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _usersignup = BehaviorSubject<String>();
  
  get emailStream => _email.stream.transform(validateEmail); 
  get passwordStream => _password.stream.transform(validatePassword);
  get submit => Observable.combineLatest2(emailStream, passwordStream, (email, password)=> true);
  
  // User sign up
  get emailSignUp => _usersignup.stream.transform(validateEmail);
  // get register => Observable.fromIterable(emailSignUp).withLatestFrom(emailSignUp, ())

  Function(String) get addEmail => _email.sink.add;
  Function(String) get addPassword => _password.sink.add;
  Function(String) get addUsersign => _usersignup.sink.add;

  Future<bool> submitMethod() async {
    return await user_login(_email.value, _password.value).then((onValue){
      print("\n$onValue\n\n");
      return true;
    });
  }
  
  Future<bool> registerUser(BuildContext context) {
    if (_usersignup != null) {
      return user_register(_usersignup.value).then((onValue){
        dialog(context, onValue['message']);
        return true;
      });
    }
  }

  dispose() {
    _email.close();
    _password.close();
    _usersignup.close();
  }

}