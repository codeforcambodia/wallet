import 'dart:async';

class ValidatorMixin {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(handleData: (value, sink){
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value == '') sink.addError('Fill your email');
    else if (!regex.hasMatch(value)) sink.addError('Invalid email');
    else sink.add('');
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(handleData: (value, sink){
    if( value == '') { sink.addError('Fill password');}
    else if ( value.length < 5) sink.addError('Password must be 5digit');
    else sink.add('');
  }); 

}