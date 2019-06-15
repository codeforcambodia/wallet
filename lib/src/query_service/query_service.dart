import 'package:graphql_flutter/graphql_flutter.dart';

String user_Id;

final String user_login_data = """
  query{
    user_login{
      id,
      email
      password
    }
  }
""";

final String addMutation = """
  mutation addData() {

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
