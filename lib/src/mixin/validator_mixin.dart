class ValidatorMixin {

  String validatorEmail(String value) {
    if ( value == '') return 'Fill email';
    else if (!value.contains('@')) return 'Invalid email';
    else return null;
  } 

  String validatorPassword(String value){
    if( value == '') {return 'Fill password';}
    else if ( value.length < 5)return 'Password must be 5digit';
    else return null;
  }

}