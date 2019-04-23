import 'package:google_sign_in/google_sign_in.dart';

class User_Data {
  //Facebook
  String id;
  String name;
  String firstName;
  String lastName;

  // String password;
  
  //Google
  String displayName;
  String email;
  String photoUrl;

  // User_Data.fromGoogle(String displayName, String email, String id, String photoUrl, String password) : 
  //   this.displayName = displayName,
  //   this.email = email,
  //   this.id = id,
  //   photoUrl = photoUrl,
  //   password = password;

  User_Data.fromFB(Map<String, dynamic> parsedJson) :
    id = parsedJson['id'],
    name = parsedJson['name'],
    firstName = parsedJson['first_name'],
    lastName = parsedJson['last_name'];

  User_Data.fromGoogle(GoogleSignInAccount googleData) :
    displayName = googleData.displayName,
    email = googleData.email,
    photoUrl = googleData.photoUrl;

}