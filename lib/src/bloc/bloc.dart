import 'package:flutter/material.dart';
import 'dart:async';
import '../mixin/validator_mixin.dart';
import 'package:rxdart/rxdart.dart';

class Bloc with ValidatorMixin{

  final _email = StreamController.broadcast();
  final _password = StreamController.broadcast();
  final _username = StreamController.broadcast();

  // User login
  get emailStream => _email.stream.transform(validateEmail); 
  get passwordStream => _password.stream.transform(validatePassword);
  get submit => Observable.combineLatest2(emailStream, passwordStream, (email, password)=> true);
  // User sign up
  get username => _username.stream.transform(validateName);

  Function(String) get addEmail => _email.sink.add;
  Function(String) get addPassword => _password.sink.add;
  Function(String) get addUsername => _username.sink.add;

  dispose() {
    _email.close();
    _password.close();
  }

}