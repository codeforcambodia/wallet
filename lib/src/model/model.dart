import 'package:google_sign_in/google_sign_in.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class User_Data {
  
  //Global
  String firstName;
  String lastName;
  String email;
  String password;
  String confirm_pass;
  String image;

  //Google
  String displayName;
  String photoUrl;

  //LinkedIn
  String accessToken;
  int expiresIn;
  String profilePicture;

  // User_Data.linkedIn(Map<String, dynamic> parsedJson) :  
  //   id = parsedJson['id'],
  //   name = parsedJson['name'],
  //   firstName = parsedJson['first_name'],
  //   lastName = parsedJson['last_name'];

  User_Data.fromGoogle(GoogleSignInAccount googleData)
      : displayName = googleData.displayName,
        email = googleData.email,
        photoUrl = googleData.photoUrl;

  User_Data.userSignUp(Map<String, dynamic> signUpData)
      : firstName = signUpData['firstName'],
        lastName = signUpData['lastName'],
        email = signUpData['email'],
        password = signUpData['password'],
        confirm_pass = signUpData['confirm'],
        image = signUpData['image'];

  // User_Data.fromQuery(QueryResult result) {
  //   Map<String, dynamic> parseData = {
  //     result.data['personal'][0]
  //   };
  // }

  User_Data();
}
