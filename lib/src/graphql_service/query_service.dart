import 'package:graphql_flutter/graphql_flutter.dart';
import '../model/model_profile.dart';

final String user_login_data = """
  query{
    user_login{
      id,
      email
      password
    }
  }
""";

String query(String userID){
  final String user_data = """
    query{
      user_data(where:{_id:{_eq:"$userID"}}){
        _id
        user_name
        phone_number
        first_name
        last_name
        email
        password
        books {
          id
          price
          title
        }
      }
    }
  """;
  return user_data;
}
